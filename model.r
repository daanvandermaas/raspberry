input_img = layer_input(shape = c(h, w, channels)) 


l1 = layer_conv_2d( filter=8, kernel_size=c(3,3),padding="same",     activation = 'relu' )(input_img) 
l1 = layer_max_pooling_2d(pool_size = c(2L,2L))(l1)
l2 = layer_conv_2d( filter=16, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1) 
l2 = layer_max_pooling_2d(pool_size = c(3L,3L))(l2)
l3 = layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2) 
l3 = layer_max_pooling_2d(pool_size = c(3L,3L))(l3)
l4 = layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3) 
l4 = layer_flatten(l4)
l4 = layer_dropout(rate = drop)(l4)
l5 = layer_dense(units = 40L, activation = 'relu')(l4)
output = layer_dense(units = class, activation = 'softmax')(l5)

model = keras_model(inputs = input_img, outputs = output)


