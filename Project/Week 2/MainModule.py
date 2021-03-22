import cv2
from PIL import Image

image = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
  
cv2.imshow('Original image',image)
cv2.imshow('Gray image', gray)

f = open('/home/iodern/CE434/Week2/GreyOpenCV.txt', 'w')
for i in range(gray.shape[0]):
    for j in range(gray.shape[1]):
        L = gray[i,j]
        x = str(L) + '\n'
        f.write (x)       
f.close()

swap = [gray.shape[1],gray.shape[0]]

f = open('/home/iodern/CE434/Week2/GreyVerilog.txt', 'r')
new_img = Image.new('L', swap)
pixels_new = new_img.load()
for i in range(new_img.size[1]):
    for j in range(new_img.size[0]):
        t = f.readline()
        pixels_new[j,i] = (int(t))
f.close()
new_img.show()


f1 = open('/home/iodern/CE434/Week2/GreyVerilog.txt', 'r')
f2 = open('/home/iodern/CE434/Week2/GreyOpenCV.txt', 'r')
acc = 0
for i in range(gray.shape[0]):
    for j in range(gray.shape[1]):
        t1 = f1.readline()
        t2 = f2.readline()  
        if (int(t1) == int(t2)):
            acc += 1
print('Accuracy: ',acc/(gray.shape[1]*gray.shape[0])*100,'%')
f1.close()
f2.close()
cv2.waitKey(0)