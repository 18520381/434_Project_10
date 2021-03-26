import cv2

imagein = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')

size = (100, 100)
image = cv2.resize(imagein, size, interpolation= cv2.INTER_AREA)


f = open('/home/iodern/CE434/Week2/RGB.txt', 'w')
for i in range(image.shape[0]):
    for j in range(image.shape[1]):
        r, g, b = image[i,j]
        x = bin(r)[2:].zfill(8) + bin(g)[2:].zfill(8) + bin(b)[2:].zfill(8) + '\n'
        f.write (x)       
f.close()
