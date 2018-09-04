images_no = list.files('db/safari/geen_boei', full.names = TRUE)
images_yes = list.files('db/safari/boeien', full.names = TRUE)


train_yes =  data.frame(images = images_yes, label = 1, stringsAsFactors = FALSE) 

samp = sample(x = c(1:nrow(train_yes)), size = nrow(train_yes), replace = FALSE)
train_yes = train_yes[samp,]
saveRDS(train_yes, 'db/train_yes.rds')




train_no =  data.frame(images = images_no, label = 0, stringsAsFactors = FALSE)
samp = sample(x = c(1:nrow(train_no)), size = nrow(train_no), replace = FALSE)
train_no= train_no[samp,]
saveRDS(train_no, 'db/train_no.rds')





images = list.files('db/safari/test', full.names = TRUE, pattern = 'jpg')

test =  data.frame('images' = images, stringsAsFactors = FALSE)



saveRDS(test, 'db/test.rds')

