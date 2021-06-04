import struct
from PIL import Image

size = (112,112)

def bintofloat(value):
    temp = int(value, 2)
    return struct.unpack('f', struct.pack('I', temp))[0]

f = open('/home/iodern/CE434/Project/Lenna2.txt', 'r')
new_img = Image.new('L', size)
pixels_new = new_img.load()
for i in range(new_img.size[1]):
    for j in range(new_img.size[0]):
        t = f.readline()
        pixels_new[j,i] = int(bintofloat(t))
f.close()
new_img.show()
