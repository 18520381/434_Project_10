import struct
from PIL import Image
import numpy as np

from tensorflow import keras
import cv2

def bintofloat(value):
    temp = int(value, 2)
    return struct.unpack('f', struct.pack('I', temp))[0]

base_model = keras.models.load_model('/home/iodern/CE434/Final/Script/model3.h5')

pic = 0
type = 'orange'


path = '/home/iodern/CE434/Final/Data_in/' + type + '/' + type + '_' + str(pic) + '.png'


x = cv2.imread(path)
x = cv2.resize(x,(112,112), interpolation= cv2.INTER_AREA)
x = cv2.cvtColor(x, cv2.COLOR_BGR2RGB)
x = x /255.0
x = np.asarray(x) 
x = np.expand_dims(x, axis=0)

conv1 = base_model.layers[0]
conv2 = base_model.layers[1]
maxpool1 = base_model.layers[2]
conv3 = base_model.layers[3]
conv4 = base_model.layers[4]
maxpool2 = base_model.layers[5]
conv5 = base_model.layers[6]
conv6 = base_model.layers[7]
conv7 = base_model.layers[8]
maxpool3 = base_model.layers[9]
conv8 = base_model.layers[10]
conv9 = base_model.layers[11]
conv10 = base_model.layers[12]
maxpool4 = base_model.layers[13]
conv11 = base_model.layers[14]
conv12 = base_model.layers[15]
conv13 = base_model.layers[16]
maxpool5 = base_model.layers[17]
glopool = base_model.layers[18]
fc1 = base_model.layers[19]
fc2 = base_model.layers[20]

lay1 = conv1(x)
lay2 = conv2(lay1)
pool1 = maxpool1(lay2)
lay3 = conv3(pool1)
lay4 = conv4(lay3)
pool2 = maxpool2(lay4)
lay5 = conv5(pool2)
lay6 = conv6(lay5)
lay7 = conv7(lay6)
pool3 = maxpool3(lay7)
lay8 = conv8(pool3)
lay9 = conv9(lay8)
lay10 = conv10(lay9)
pool4 = maxpool4(lay10)
lay11 = conv11(pool4)
lay12 = conv12(lay11)
lay13 = conv13(lay12)
pool5 = maxpool5(lay13)
glob = glopool(pool5)
full1 = fc1(glob)
full2 = fc2(full1)

x = x.squeeze()

lay1 = lay1.numpy()
lay1 = lay1.squeeze()

lay2 = lay2.numpy()
lay2 = lay2.squeeze()

pool1 = pool1.numpy()
pool1 = pool1.squeeze()

lay3 = lay3.numpy()
lay3 = lay3.squeeze()

lay4 = lay4.numpy()
lay4 = lay4.squeeze()

pool2 = pool2.numpy()
pool2 = pool2.squeeze()

lay5 = lay5.numpy()
lay5 = lay5.squeeze()

lay6 = lay6.numpy()
lay6 = lay6.squeeze()

lay7 = lay7.numpy()
lay7 = lay7.squeeze()

pool3 = pool3.numpy()
pool3 = pool3.squeeze()

lay8 = lay8.numpy()
lay8 = lay8.squeeze()

lay9 = lay9.numpy()
lay9 = lay9.squeeze()

lay10 = lay10.numpy()
lay10 = lay10.squeeze()

pool4 = pool4.numpy()
pool4 = pool4.squeeze()

lay11 = lay11.numpy()
lay11 = lay11.squeeze()

lay12 = lay12.numpy()
lay12 = lay12.squeeze()

lay13 = lay13.numpy()
lay13 = lay13.squeeze()

pool5 = pool5.numpy()
pool5 = pool5.squeeze()

glob = glob.numpy()
glob = glob.squeeze()

full1 = full1.numpy()
full1 = full1.squeeze()

full2 = full2.numpy()
full2 = full2.squeeze()

res = open('/home/iodern/CE434/Final/Data_out/' + type + str(pic) + '/Result.txt', 'w')

#----------------

for y in range(1,16):

  img = [0,112,56,56,28,28,28,14,14,14,7,7,7,1,1,1]
  lay = [0,8,8,16,16,32,32,32,32,32,32,32,32,32,16,2]

  layer = lay[y]
  img_size = img[y]
  size = (img_size, img_size)
  accu = 0
  z = layer-1

  if y >= 1 and y <= 14:
    f = open('/home/iodern/CE434/Final/Data_out/' + type + str(pic) + '/input_layer'+ str(y+1) +'.txt', 'r')
  elif y == 15:
    f = open('/home/iodern/CE434/Final/Data_out/' + type + str(pic) + '/outCNN.txt', 'r')

  t = f.readline()
  t = f.readline()
  t = f.readline()
  for i in range(size[0]):
    for j in range(size[1]):
      for k in range(0, layer):   
          t = f.readline(32)
          x = float(bintofloat(t))
          if y == 1:
            accu += (x - lay1[i][j][z-k])*(x - lay1[i][j][z-k])
            lay1[i][j][z-k] = x
          elif y == 2:
            accu += (x - pool1[i][j][z-k])*(x - pool1[i][j][z-k])
            pool1[i][j][z-k] = x
          elif y == 3:
            accu += (x - lay3[i][j][z-k])*(x - lay3[i][j][z-k])
            lay3[i][j][z-k] = x
          elif y == 4:
            accu += (x - pool2[i][j][z-k])*(x - pool2[i][j][z-k])
            pool2[i][j][z-k] = x
          elif y == 5:
            accu += (x - lay5[i][j][z-k])*(x - lay5[i][j][z-k])
            lay5[i][j][z-k] = x
          elif y == 6:
            accu += (x - lay6[i][j][z-k])*(x - lay6[i][j][z-k])
            lay6[i][j][z-k] = x
          elif y == 7:
            accu += (x - pool3[i][j][z-k])*(x - pool3[i][j][z-k])
            pool3[i][j][z-k] = x
          elif y == 8:
            accu += (x - lay8[i][j][z-k])*(x - lay8[i][j][z-k])
            lay8[i][j][z-k] = x
          elif y == 9:
            accu += (x - lay9[i][j][z-k])*(x - lay9[i][j][z-k])
            lay9[i][j][z-k] = x
          elif y == 10:
            accu += (x - pool4[i][j][z-k])*(x - pool4[i][j][z-k])
            pool4[i][j][z-k] = x
          elif y == 11:
            accu += (x - lay11[i][j][z-k])*(x - lay11[i][j][z-k])
            lay11[i][j][z-k] = x
          elif y == 12:
            accu += (x - lay12[i][j][z-k])*(x - lay12[i][j][z-k])
            lay12[i][j][z-k] = x
          elif y == 13:
            accu += (x - glob[layer-1-k])*(x - glob[layer-1-k])
            # print(glob[layer-1-k], "\t\t", x)
          elif y == 14:
            accu += (x - full1[layer-1-k])*(x - full1[layer-1-k])
            # print(full1[layer-1-k], "\t\t", x)
          elif y == 15:
            accu += (x - full2[layer-1-k])*(x - full2[layer-1-k])
            res.write(str(full2[layer-1-k]) + "\t\t" + str(x) + "\n")
      t = f.readline()
  f.close()

  res.write("Mean square error layer " + str(y) + ": " + str(accu/(img_size*img_size*layer)) + "\n")
res.close()