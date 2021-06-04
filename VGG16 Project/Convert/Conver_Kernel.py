import struct

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

fr = open('block1_conv1_kernel2.txt','r')
fw = open('block1_conv1_kernel3.txt','w')
for i in range(27):
  t = binary(float(fr.readline()))
  fw.write(t + '\n')
fr.close()
fw.close()