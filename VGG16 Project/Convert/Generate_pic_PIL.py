import struct
from PIL import Image

def bintofloat(value):
    temp = int(value, 2)
    return struct.unpack('f', struct.pack('I', temp))[0]

accu2 = 0

layer = 8

img_size = 56
size = (img_size, img_size)

for k in range(0, 1):
  print(k)
  accu = 0
  f = open('/content/drive/MyDrive/ColabNotebooks/data/Lenna_convert' + str(k) + '.txt', 'r')
  new_img = Image.new('RGB', size)
  pixels_new = new_img.load()
  t = f.readline()
  t = f.readline()
  t = f.readline()
  for i in range(new_img.size[0]):
    for j in range(new_img.size[1]):
        t = f.readline()
        x = float(bintofloat(t))
        pixels_new[j,i] = int(x*255), int(x*255), int(x*255)
        # accu += (x - y[i][j][k]/255.0)*(x - y[i][j][k]/255.0)
        
  f.close()
  # print("pic ", k,":",accu/(112*112))
  # accu2 += accu
  plt.imshow(new_img)
  plt.show()
  new_img.show()

# print("total :", accu2/(112*112*8))