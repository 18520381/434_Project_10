import cv2
import struct

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

imagein = cv2.imread('/content/drive/MyDrive/ColabNotebooks/data/Lenna.png')
size = (112, 112)
image = cv2.resize(imagein, size, interpolation= cv2.INTER_AREA)

f = open('/content/drive/MyDrive/ColabNotebooks/data/Lenna_conv.txt', 'w')

for i in range(image.shape[0]):
    for j in range(image.shape[1]):
        b, g, r = image[i,j]
        x = binary(b/255.0) + binary(g/255.0) + binary(r/255.0) + '\n'
        f.write(x)       
f.close()