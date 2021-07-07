import struct
from PIL import Image


from tensorflow import keras
import cv2

base_model = keras.models.load_model('/content/drive/MyDrive/ColabNotebooks/data/model6.h5')

path = '/content/drive/MyDrive/ColabNotebooks/data/Lenna.png'
x = cv2.imread(path)
x = cv2.resize(x,(112,112), interpolation= cv2.INTER_AREA)
x = cv2.cvtColor(x, cv2.COLOR_BGR2RGB)
x = x /255.0
x.shape

conv1 = base_model.layers[0]
conv2 = base_model.layers[1]
maxpool1 = base_model.layers[2]
conv3 = base_model.layers[3]
conv4 = base_model.layers[4]
maxpool2 = base_model.layers[5]
conv5 = base_model.layers[6]

lay1 = conv1(x[np.newaxis,:,:,:])
lay2 = conv2(lay1)
pool1 = maxpool1(lay2)
lay3 = conv3(pool1)
lay4 = conv4(lay3)
pool2 = maxpool2(lay4)
lay5 = conv5(pool2)

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

feature_map_show(lay5, "KERAS_Layer5")

layer = 8
img_size = 28
size = (img_size, img_size)

def bintofloat(value):
    temp = int(value, 2)
    return struct.unpack('f', struct.pack('I', temp))[0]

accu = 0

for k in range(0, layer):
  f = open('/content/drive/MyDrive/ColabNotebooks/data/Lenna_convert' + str(k) + '.txt', 'r')
  t = f.readline()
  t = f.readline()
  t = f.readline()
  for i in range(size[0]):
    for j in range(size[1]):
        t = f.readline()
        x = float(bintofloat(t))
        accu += (x - lay5[i][j][k])*(x - lay5[i][j][k])
        lay5[i][j][k] = x
  f.close()

print("Mean square error:",accu/(img_size*img_size*layer))

feature_map_show(lay5, "RTL_Layer5")