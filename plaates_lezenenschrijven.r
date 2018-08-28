###########################################################33

#INIT

#https://stackoverflow.com/questions/33409363/convert-r-image-to-base-64

library(base64enc)

library(RMySQL)



con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )

dbSendQuery(con, "DROP TABLE digitaalschouwen")

dbSendQuery(con, "CREATE TABLE digitaalschouwen (photo LONGTEXT)")





###########################################################33

#DIT OP RASPI DRAAIEN

txt <- base64enc::base64encode("db/z.jpg")

dbSendQuery(con, paste0("INSERT INTO `ad_2de5416a43df6e8`.`digitaalschouwen`(`photo`) VALUES('",txt,"')"))

print(object.size(txt))

rm(txt)





###########################################################33

#DIT OM PLAATJES VANUIT MYSQL WEER TE GEVEN



#inladen

tst <- dbReadTable(con, "digitaalschouwen")

print(object.size(tst))



#base64 image in browser weergeven

html <- sprintf('<html><body><img src="data:image/png;base64,%s"></body></html>', tst[1,1])

cat(html, file = tf2 <- tempfile(fileext = ".html"))

im = readImage(tf2)

browseURL(tf2)









#disconnect

suppressWarnings(dbDisconnect(con))

rm(con)