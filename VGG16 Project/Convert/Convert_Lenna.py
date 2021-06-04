import cv2
import struct

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

imagein = cv2.imread('/home/iodern/CE434/Project/Lenna.png')

size = (112, 112)
image = cv2.resize(imagein, size, interpolation= cv2.INTER_AREA)
#gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)


f = open('/home/iodern/CE434/Project/Lenna_conv.txt', 'w')
for i in range(image.shape[0]):
    for j in range(image.shape[1]):
        r, g, b = image[i,j]
        x = binary(b) + binary(g) + binary(r) + '\n'
        f.write(x)       
f.close()


#f = open('/home/iodern/CE434/Project/Lenna2.txt', 'w')
#for i in range(gray.shape[0]):
#    for j in range(gray.shape[1]):
#        L = gray[i,j]
#        x = binary(L) + '\n'
#        f.write (x)       
#f.close()
