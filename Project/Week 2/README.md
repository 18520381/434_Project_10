# Convert RBG to Grayscales of an image

Create a txt with R G B value by OpenCV

```python
import cv2

image = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')
 
f = open('/home/iodern/CE434/Week2/RGB.txt', 'w')
for i in range(image.shape[0]):
    for j in range(image.shape[1]):
        r, g, b = image[i,j]
        x = str(r) + '\t' + str(g) + '\t' + str(b) + '\n'
        f.write (x)       
f.close()

```

Convert R G B value to L value by Verilog

```

```

Convert R G B value to L value by OpenCV

```python
import cv2

image = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

f = open('/home/iodern/CE434/Week2/GreyOpenCV.txt', 'w')
for i in range(gray.shape[0]):
    for j in range(gray.shape[1]):
        L = gray[i,j]
        x = str(L) + '\n'
        f.write (x)       
f.close()
```

Convert L value from txt to an image by Pillow
```python
import cv2
from PIL import Image

image = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')

swap = [image.shape[1],image.shape[0]]

f = open('/home/iodern/CE434/Week2/GreyVerilog.txt', 'r')
new_img = Image.new('L', swap)
pixels_new = new_img.load()
for i in range(new_img.size[1]):
    for j in range(new_img.size[0]):
        t = f.readline()
        pixels_new[j,i] = (int(t))
f.close()

```

Compare the different from 2 kind of image (OpenCV and Verilog)
```python
import cv2

image = cv2.imread('/home/iodern/CE434/Week2/test04.jpg')

f1 = open('/home/iodern/CE434/Week2/GreyVerilog.txt', 'r')
f2 = open('/home/iodern/CE434/Week2/GreyOpenCV.txt', 'r')
acc = 0
for i in range(image.shape[0]):
    for j in range(image.shape[1]):
        t1 = f1.readline()
        t2 = f2.readline()  
        if (int(t1) == int(t2)):
            acc += 1
print('Accuracy: ',acc/(image.shape[1]*image.shape[0])*100,'%')
f1.close()
f2.close()

```
