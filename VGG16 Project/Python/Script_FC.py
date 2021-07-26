from tensorflow import keras
import cv2
import sys
import numpy
import re
import struct


base_model = keras.models.load_model('/home/iodern/CE434/Final/Script/model3.h5') 

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

fully = [19,20]
lay = [16,2]
conv = [32,16]
valid = [6,5]

for z in range(0,2):
    fc = base_model.layers[fully[z]]
    kernel1 = fc.get_weights()[0]
    bias1 = fc.get_weights()[1]

    layer = lay[z]
    conv2d = conv[z]

    f = open('/home/iodern/CE434/Final/RTL/core/layer' + str(14+z) + '_1.v', 'w')

    f.write("module layer" + str(14+z) + "_1#(\n")
    f.write("  parameter DATA_WIDTH = 32\n")
    f.write("  )(\n")
    f.write("  input  [DATA_WIDTH*" + str(conv2d) + "-1:0] i_data,\n")
    f.write("  input         clk, rst, valid_in,\n")
    f.write("  output reg[DATA_WIDTH*" + str(layer) + "-1:0] o_data ,\n")
    f.write("  output valid_out\n")
    f.write("  );\n")
    f.write("  \n")
    f.write("  wire [" + str(valid[z]) + ":0] valid_FC;\n")
    f.write("\n")

    for i in range(0, layer):
        if (z == 0):
            f.write("  FC#(\n")
        else:
            f.write("  FC_16#(\n")
        f.write("  .DATA_WIDTH(DATA_WIDTH),\n")
        for j in range(0, conv2d):
            f.write("      .k" + str(j+1) + "(32'b" + binary(kernel1[j][i]) + "),\n")
        f.write("      .bias(32'b" + binary(bias1[i]) + ")\n")
        f.write("  ) FC" + str(i+1) + " (\n")
        f.write("      .i_data(i_data),\n")
        f.write("      .clk(clk), \n")
        f.write("      .rst(rst), \n")
        f.write("      .valid_in(valid_in),\n")
        if (z == 0):
            f.write("      .valid_FC(valid_FC),\n")
        else:
            f.write("      .valid_pipeline_FC(valid_FC),\n")
        f.write("      .o_data(o_data[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "])  \n")
        f.write("  );\n")
        f.write("\n")
        
    if (z == 0):
        f.write(" control_FC control1(\n")
    else:
        f.write(" control_FC_16 control1(\n")
    if (z == 0):
        f.write("       .valid_in(valid_in), \n")
    else:
        f.write("       .valid_in_FC(valid_in), \n")
    f.write("       .clk(clk), \n")
    f.write("       .rst(rst),\n")
    f.write("       .valid_out(valid_out),\n")
    if (z == 0):    
        f.write("       .valid_FC(valid_FC)  \n")
    else:
        f.write("       .valid_in_FC1(valid_FC)  \n")
    f.write("  );\n")
    f.write("endmodule\n")

    f.close()