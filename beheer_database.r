library(RMySQL)
con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )

dbListTables(con)

q = 'DROP TABLE digitaalschouwen'

dbSendQuery(con , q)



q = 'CREATE TABLE digitaalschouwen ( photo BLOB )'



q = paste0("INSERT INTO digitaalschouwen (photo) VALUES (LOAD_FILE(x.png)) ")
dbSendQuery(con , q)




q = 'CREATE TABLE digitaalschouwen (id VARCHAR(150), time VARCHAR(30), prediction INT , location_x VARCHAR(30), location_y VARCHAR(30), location_old_x VARCHAR(30), location_old_y VARCHAR(30), photo TEXT )'
z = dbSendQuery(con , q)



con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )

q = 'SELECT location_x, location_y, id FROM digitaalschouwen LIMIT 100'
z = dbSendQuery(con , q)
data = fetch(z, n=-1)
data

q = paste0("SELECT photo FROM digitaalschouwen WHERE id = '", p, "'" )
z = dbSendQuery(con , q)
data = fetch(z, n=-1)
dbDisconnect(con)

im = base64enc::base64decode(data[1,1])
writeJPEG(im(), 'temp.jpg' )




