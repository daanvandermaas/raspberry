library(EBImage)
library(keras)
library(data.table)

source('read_files.r')

train = readRDS('db/train_new.rds')
test = readRDS('db/test_new.rds')
train$file = as.character( file.path('db', 'images_pieces', train$class, train$file))
test$file = as.character( file.path('db', 'images_pieces', test$class, test$file))

max_acc = 0.96

w = 128
h = 64


model<-keras_model_sequential()



model %>%  
  layer_conv_2d(filter=32, kernel_size=c(4,4),padding="same",    input_shape=c(w,h,3) , activation = 'relu') %>%  
  layer_conv_2d(filter=64 ,kernel_size=c(4,4), padding = 'same', activation = 'relu')  %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  layer_conv_2d(filter=64 ,kernel_size=c(3,3), padding = 'same', activation = 'relu')  %>%  
  layer_conv_2d(filter=64 ,kernel_size=c(3,3), padding = 'same', activation = 'relu')  %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  layer_conv_2d(filter=64 ,kernel_size=c(3,3), padding = 'same', activation = 'relu')  %>%  
  layer_conv_2d(filter=64 , kernel_size=c(3,3),padding="same", activation = 'relu') %>%
  layer_flatten() %>%
  layer_dropout(0.5) %>%
  layer_dense(units = 40L , activation = 'relu') %>%
  layer_dense(units = 10L , activation = 'relu') %>%
  layer_dense(units = 2L , activation = 'softmax')

opt<-optimizer_adam( lr= 1e-4 , decay = 1e-6 )

model %>%
  compile(loss="categorical_crossentropy", optimizer=opt, metrics = "accuracy")


#model = keras::load_model_hdf5('db/model')



#Train the network
train_acc = c()
test_acc = c()
train_loss = c()
test_loss = c()
step = c()


for (i in 1:2000000) {
  
  
  files = read_files(data = train, w, h, n = 12)
  print(i)
  model$fit( x= files[[1]], y= files[[2]], batch_size = dim(files[[1]])[1], epochs = 1L  )
  
  if(i%%20 == 0 ){
    
    step = c(step, i)
    
    files = read_files(data = test, w, h, n = 64)
    ev =   model$evaluate(x = files[[1]], y = files[[2]] )
    test_acc = c(test_acc, ev[[2]])
    test_loss = c(test_loss, ev[[1]])
    print(paste('test evaluation:',     ev[[2]] ))
    
    if(ev[[2]]> max_acc){
      max_acc = ev[[2]]
      model$save('db/model' )
      
    }
    
    files = read_files(data = train, w, h, n = 40)
    ev =   model$evaluate(x = files[[1]], y = files[[2]] )
    train_acc = c(train_acc , ev[[2]])
    train_loss = c(train_loss, ev[[1]])
    print(paste('train evaluation:',     ev[[2]] ))
  }
  
  
}


model$save('model')
