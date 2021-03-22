import cv2

image = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')
 
f = open('/home/iodern/CE434/Week2/RGB.txt', 'w')
for i in range(image.shape[0]):
    for j in range(image.shape[1]):
        r, g, b = image[i,j]
        x = str(r) + '\t' + str(g) + '\t' + str(b) + '\n'
        f.write (x)       
f.close()
