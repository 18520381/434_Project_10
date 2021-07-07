import math
import struct
from PIL import Image
img_size = 112
size = (img_size, img_size)

from tensorflow import keras
import cv2

base_model = keras.models.load_model('/content/drive/MyDrive/ColabNotebooks/data/model6.h5')

path = '/content/drive/MyDrive/ColabNotebooks/data/Lenna.png'
x = cv2.imread(path)
x = cv2.resize(x,(112,112), interpolation= cv2.INTER_AREA)
x = cv2.cvtColor(x, cv2.COLOR_BGR2RGB)
x = x / 255.0

conv1 = base_model.layers[0]
conv2 = base_model.layers[1]
maxpool1 = base_model.layers[2]

lay1 = conv1(x[np.newaxis,:,:,:])
lay2 = conv2(lay1)
lay3 = maxpool1(lay2)

lay1 = lay1.numpy()
lay1 = lay1.squeeze()

lay2 = lay2.numpy()
lay2 = lay2.squeeze()

lay3 = lay3.numpy()
lay3 = lay3.squeeze()

# feature_map_show(lay2, "KERAS_Layer2")
kernel1 = base_model.layers[0].get_weights()[0]
bias1   = base_model.layers[0].get_weights()[1]
kernel2 = base_model.layers[1].get_weights()[0]
bias2   = base_model.layers[1].get_weights()[1]


kernel = 3
conv2d = 8
layer = 8
size = 112

for i in range (0, 1):
  for u in range (0, size):
    for v in range (0, size):
      t1 = 0
      for j in range (0, conv2d):
        t0 = 0
        # if (u==0) and (v==0):
        #   print("conv2d_",j,"////////////////")
        for k in range (-1, kernel-1):
          for l in range (-1, kernel-1):
            if ((u+k >= 0) and (v+l >=0) and (u+k < size) and (v+l < size)):           
              t0 += lay1[u+k][v+l][j]*kernel2[k+1][l+1][j][i]
            # if (u==0) and (v==0):
            #   print(u+k," ",v+l," ",lay1[u+k][v+l][j]," ",kernel2[k+1][l+1][j][i]," ",lay1[u+k][v+l][j]*kernel2[k+1][l+1][j][i])
        t1 += t0
        # if (u==0) and (v==0):
        #   print("tong conv:",t0)
      t1 += bias2[i]
      # if (u==0) and (v==0):
      #     print("bias:",bias2[i],"\n\n",t1)

      # accu += abs(lay2[u][v][i]/255.0 - t1)
      if (t1>=0):
        lay2[u][v][i] = t1
      else:
        lay2[u][v][i] = 0
  # print("pic ",i," : ",1-accu/(size*size))    


# feature_map_show(lay2, "PYTHON_layer2")