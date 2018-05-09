library(keras)
library(jpeg)


model = keras::load_model_hdf5('model')

files = list.files(pattern = 'jpg')

im = readJPEG(files[1])

im = array(im, dim = c(1, dim(im)))

im = aperm(im, c(1,3,2,4))

model$predict_classes(im)



