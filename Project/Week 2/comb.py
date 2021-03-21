import cv2
from PIL import Image

image = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
  
cv2.imshow('Original image',image)
cv2.imshow('Gray image', gray)

f = open('/home/iodern/CE434/Week2/binary1.txt', 'w')
for i in range(gray.shape[0]):
    for j in range(gray.shape[1]):
        L = gray[i,j]
        x = str(L) + '\n'
        f.write (x)       
f.close()

swap = [gray.shape[1],gray.shape[0]]

f = open('/home/iodern/CE434/Week2/binary.txt', 'r')
new_img = Image.new('L', swap)
pixels_new = new_img.load()
for i in range(new_img.size[1]):
    for j in range(new_img.size[0]):
        t = f.readline()
        pixels_new[j,i] = (int(t))
f.close()
new_img.show()


f1 = open('/home/iodern/CE434/Week2/binary1.txt', 'r')
f2 = open('/home/iodern/CE434/Week2/binary.txt', 'r')
acc = 0
for i in range(gray.shape[0]):
    for j in range(gray.shape[1]):
        if (f1.readline == f2.readline):
            acc += 1
print('Accuacncy: ',acc)
f2.close()
f2.close()
cv2.waitKey(0)