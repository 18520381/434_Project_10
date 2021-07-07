base_model = keras.models.load_model('/content/drive/MyDrive/ColabNotebooks/data/model6.h5') 

kernel1 = base_model.layers[0].get_weights()[0]
bias1   = base_model.layers[0].get_weights()[1]

kernel = 3
conv2d = 3
layer = 8

for k in range(0, layer):
  print("conv3d_",k+1)
  for l in range(0, conv2d):
    print("conv2d_",k*conv2d+l+1)
    for i in range (0, kernel):
      for j in range (0, kernel):
        print(kernel1[i][j][l][k])