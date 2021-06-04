import struct

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

fr = open('block1_conv1_bias.txt','r')
fw = open('block1_conv1_bias2.txt','w')
for i in range(64):
  t = binary(float(fr.readline()))
  fw.write(t + '\n')
fr.close()
fw.close()