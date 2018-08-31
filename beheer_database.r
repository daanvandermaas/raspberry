library(RMySQL)


con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
dbListTables(con)

con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
q = 'DROP TABLE digitaalschouwen'
dbSendQuery(con , q)






q = 'CREATE TABLE digitaalschouwen (id VARCHAR(150), time VARCHAR(30), prediction INT , location_x VARCHAR(30), location_y VARCHAR(30), location_old_x VARCHAR(30), location_old_y VARCHAR(30), photo LONGTEXT )'
z = dbSendQuery(con , q)



#place photo in db
con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
txt <- base64enc::base64encode("z.jpg")
dbSendQuery(con, paste0("INSERT INTO digitaalschouwen (id, time, prediction, location_x, location_y, location_old_x, location_old_y, photo) VALUES ('1', '1', 1, '1', '1', '1', '1' ,'", txt  , "')"))
dbDisconnect(con)




con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
q = 'SELECT location_x, location_y, id FROM digitaalschouwen'
z = dbSendQuery(con , q)
data = fetch(z, n=-1)
data



q = paste0("SELECT photo FROM digitaalschouwen WHERE id = '", p, "'" )
z = dbSendQuery(con , q)
data = fetch(z, n=-1)
dbDisconnect(con)




con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
q = paste0("SELECT * FROM digitaalschouwen"  )
z = dbSendQuery(con , q)
data = fetch(z, n=-1)
dbDisconnect(con)









con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )

q = 'select id FROM digitaalschouwen LIMIT 9 '
z = dbSendQuery(con , q)
ids = fetch(z, n=-1)
ids = ids[,1]

ids_last = ids[length(ids)]
ids = ids[-length(ids)]
ids = paste0('\'', ids, '\', ')
ids = paste(ids, collapse = ' ' )
ids = paste0(ids, ' \'', ids_last, '\'')

q = paste0('DELETE FROM digitaalschouwen WHERE id NOT IN (', ids ,')' )
z = dbSendQuery(con , q)

dbDisconnect(con)
