
library(keras)
library(jpeg)
library(abind)


######Parameters
epochs = 280
batch_size = 2L
h = as.integer(512) #heigth image dim image = 2448
w = as.integer(1024) #width image
channels = 3L
class = 2L
drop = 0.5
#####

source('model.r')
opt<-optimizer_adam( lr= 0.0001 , decay = 0,  clipnorm = 1 )
compile(model, loss="categorical_crossentropy", optimizer=opt, metrics = "accuracy")


#data loading
train_yes = readRDS( 'db/train_yes.rds' )
train_no = readRDS( 'db/train_no.rds' )



i= 1
#Train the network
for (epoch in 11:epochs){
  
  order = sample(c(1:nrow(train_yes) ), nrow(train_yes), replace = FALSE)
  train_yes = train_yes[order,]
  
  order = sample(c(1:nrow(train_no) ), nrow(train_no), replace = FALSE)
  train_no = train_no[order,]
  
  
    for(i in 1:nrow(train_yes)){
    
    
    
   im_yes = readJPEG(train_yes$images[i])[257:768,,]
   im_no = readJPEG(train_no$images[i])[257:768,,]
   
   im_yes = array(im_yes, dim = c(1, dim(im_yes)))
   im_no = array(im_no, dim = c(1, dim(im_no)))
   
   input_im = abind(im_yes, im_no, along = 1)
   
   
   input_lab = matrix(c(1,0,0,1), nrow = 2, ncol = 2, byrow = TRUE)
     
    model$fit( x= input_im, y= input_lab, batch_size = batch_size, epochs = 1L )
    
  }
  print(paste('epoch:', epoch))
  model$save( paste0('db/model/model_small_', epoch) )
  
  
  
  
}


#model$evaluate(x = batch_files, y = batch_labels)

#model = keras::load_model_hdf5('db/model/model_big_10')