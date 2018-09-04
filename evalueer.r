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



model = keras::load_model_hdf5('db/model/model_50')



test = readRDS('db/test.rds')

i=1
for(i in 1:nrow(test)){
  
  im = readJPEG(test$images[i])[257:768,,]
  im_input = array(im, dim = c(1, dim(im)))
  
 lab =   model$predict(im_input)
 
 
  
  if(lab[1] > 0.99){
    writeJPEG(im, paste0('db/safari/boeien_test/image_',i, '.jpg'))
  }else{
    writeJPEG(im, paste0('db/safari/niet_boeien_test/image_',i, '.jpg'))
  }
  
}
