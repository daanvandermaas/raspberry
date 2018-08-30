library(shiny)
library(base64enc)
library(RPostgreSQL)
library(RMySQL)
library(leaflet)
library(jpeg)


con <- dbConnect(dbDriver("PostgreSQL"), dbname = "dl_wegdata_productie", host = "10.113.111.240", user = "svc-ad-pdatalab", port=5432, password = 'PD@t@L@b$vc!')
#con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
q = 'SELECT id, time, location_x, location_y FROM digitaalschouwen'
z = dbSendQuery(con , q)
data = fetch(z, n=-1)
dbDisconnect(con)

data = data[ !is.na(data[,1]) , ]
data = cbind( as.numeric(data$location_y), as.numeric(data$location_x), data$id)
data = as.data.frame(data)
colnames(data) = c('x', 'y', 'id')
data$x = as.numeric(as.character(data$x))
data$y = as.numeric(as.character(data$y))
data$id = as.character(data$id)


ui <- fluidPage(
  headerPanel("Digitaalschouwen"),
  
  mainPanel(
  leafletOutput("map"),
  imageOutput("image")
))



server <- function(input, output) {
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(options = providerTileOptions(noWrap = TRUE)) %>%
      addCircleMarkers(data=data, ~x , ~y, layerId=~id, popup=~id, radius=8 , color="black",  fillColor="red", stroke = TRUE, fillOpacity = 0.8)
  })
  
  # reactive expression
  im <- eventReactive( input$map_marker_click, {
    
    p = input$map_marker_click$id
    print(p)
    
    con <- dbConnect(dbDriver("PostgreSQL"), dbname = "dl_wegdata_productie", host = "10.113.111.240", user = "svc-ad-pdatalab", port=5432, password = 'PD@t@L@b$vc!')
    #con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
    q = paste0("SELECT photo FROM digitaalschouwen WHERE id = '", p, "'" )
    z = dbSendQuery(con , q)
    data = fetch(z, n=-1)
    dbDisconnect(con)
    
    con <- file("test.jpg","wb")
    base64decode(what=data[1,1], output=con) #txt is je based64encode string
    close(con)
    
    'test.jpg'
    
  })
  
  
  #image output
  output$image <- renderImage({
   # Return a list containing the filename
    list(src = im(),
         contentType = 'image/png',
         width = 400,
         height = 400,
         alt = "De foto van de gemaakte waarneming.")
  }, deleteFile = FALSE)
  
  
  
  
  
}

shinyApp(ui = ui, server = server)