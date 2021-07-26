import cv2
import struct

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

for i in range (0,5):
    imagein = cv2.imread('/home/iodern/CE434/Final/Data_in/apple/apple_' + str(i) + '.png')
    size = (112, 112)
    image = cv2.resize(imagein, size, interpolation= cv2.INTER_AREA)

    f = open('/home/iodern/CE434/Final/Data_in/apple/apple' + str(i) + '.txt', 'w')

    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            b, g, r = image[i,j]
            x = binary(b/255.0) + binary(g/255.0) + binary(r/255.0) + '\n'
            f.write(x)       
    f.close()

for i in range(0,5):
    imagein = cv2.imread('/home/iodern/CE434/Final/Data_in/orange/orange_' + str(i) + '.png')
    size = (112, 112)
    image = cv2.resize(imagein, size, interpolation= cv2.INTER_AREA)

    f = open('/home/iodern/CE434/Final/Data_in/orange/orange' + str(i) + '.txt', 'w')

    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            b, g, r = image[i,j]
            x = binary(b/255.0) + binary(g/255.0) + binary(r/255.0) + '\n'
            f.write(x)       
    f.close()
