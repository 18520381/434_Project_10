from tensorflow import keras
import cv2
import sys
import numpy
import re
import struct

base_model = keras.models.load_model('/home/iodern/CE434/Final/Script/model3.h5')

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

size = 112
layer = 8

withd = [0,size,size,size//2,size//2,size//4,size//4,size//4,
        size//8,size//8,size//8,size//16,size//16,size//16]

mod = [0,0,1,3,4,6,7,8,10,11,12,14,15,16]
conv = [0,3,layer,layer,layer*2,layer*2,layer*4,layer*4,layer*4,
        layer*4,layer*4,layer*4,layer*4,layer*4]
lay = [0,layer,layer,layer*2,layer*2,layer*4,layer*4,layer*4,layer*4,
       layer*4,layer*4,layer*4,layer*4,layer*4]

pi_bi = [0,1,3,3,4,4,5,5,5,5,5,5,5,5]
pi_lay = [0,1,2,2,4,4,6,6,6,6,6,6,6,6]
con_lay = [0,1,2,3,4,5,6,7,6,6,7,6,6,13]
max = [False,False,True,False,True,False,False,True,False,False,True,False,False,True]

for z in range (1,14):
    kernel1 = base_model.layers[mod[z]].get_weights()[0]
    bias1   = base_model.layers[mod[z]].get_weights()[1]

    kernel = 3
    conv2d = conv[z]
    layer = lay[z]
    pipe_bias = pi_bi[z]
    pipe_layer = pi_lay[z]
    control_layer = con_lay[z]

    f = open('/home/iodern/CE434/Final/RTL/core/layer' + str(z) + '_1.v', 'w')

    f.write("module layer" + str(z) + "_1#(\n")
    f.write("    parameter DATA_WIDTH = 32,\n")
    f.write("    parameter WIDTH = " + str(withd[z]) + "\n")
    f.write(")(\n")
    f.write("  input  [DATA_WIDTH*" + str(conv2d) + "-1:0] i_data,\n")
    f.write("  input              clk, rst, valid_in,\n")
    f.write("  output [DATA_WIDTH*" + str(layer) + "-1:0] o_data,\n")
    f.write("  output             valid_out\n")       
    f.write(");\n")
    f.write("  wire [DATA_WIDTH*" + str(conv2d) + "-1:0] i_CORE_IP1 [" + str(layer-1) + ":0];\n")
    if (max[z]):
        f.write("  wire [DATA_WIDTH*" + str(conv2d) + "-1:0] i_CORE_IP2;\n")
        if (z == 13):
            f.write("  wire [DATA_WIDTH*" + str(conv2d) + "-1:0] i_CORE_IP3;\n")
    f.write("  wire padding_valid, valid_in_pipeline2D, valid_in_bias;\n")
    f.write("  wire [31:0] counter_col, counter_row;\n")
    if (max[z]):
        f.write("  wire valid_in_maxpooling, valid_in_max, valid_in_max1; \n")
        if (z == 13):
            f.write("  wire valid_in_maxpooling3x3, valid_in_max3x3;\n")
            f.write("  wire [2:0] valid_in_max13x3; \n")
    f.write("  wire [3:0] valid_pipeline2D;\n")
    f.write("  wire [" + str(pipe_bias) + ":0] valid_pipeline_bias;\n")
    f.write("\n")
    for i in range(0, layer):
        f.write("/// CON2D_" + str(i+1) + "///////////////////\n")
        for j in range(0, conv2d):
            f.write("  Con2D #(\n")
            f.write("      .DATA_WIDTH(DATA_WIDTH),\n")
            f.write("      .WIDTH(WIDTH),\n")
            for k in range(0, kernel):
                for l in range(0, kernel):
                    f.write("      .k" + str(k*3+l+1) + "(32'b" + binary(kernel1[k][l][j][i]) + ")")
                    if (k*3+l) != 8:
                        f.write(",\n")
                    else:
                        f.write("\n")
            f.write("  ) CON2D_" + str(i*conv2d+j+1) + "(\n")
            f.write("      .i_data(i_data[DATA_WIDTH*" + str(j+1) + "-1:DATA_WIDTH*" + str(j) + "]),\n")
            f.write("      .clk(clk), \n")
            f.write("      .rst(rst), \n")
            f.write("      .valid_in(padding_valid),\n")
            f.write("      .valid_in_pipeline2D(valid_in_pipeline2D),\n")
            f.write("      .counter_col(counter_col),\n")
            f.write("      .counter_row(counter_row),\n")
            f.write("      .valid_pipeline2D(valid_pipeline2D),\n")
            f.write("      .o_data(i_CORE_IP1[" + str(i) + "][DATA_WIDTH*" + str(j+1) + "-1:DATA_WIDTH*" + str(j) + "])\n")
            f.write("  );\n")
            f.write("\n") 

        f.write("\n")  
        f.write("pipeline_layer" + str(pipe_layer) + "#(\n")
        f.write("    .DATA_WIDTH(DATA_WIDTH),\n")
        f.write("    .bias(32'b" + binary(bias1[i]) + ")\n")
        f.write(")   op" + str(i+1) + "(\n")
        f.write("    .i_pipeline_layer" + str(pipe_layer) + "(i_CORE_IP1[" + str(i) + "]), \n")
        f.write("    .clk(clk),\n") 
        f.write("    .rst(rst),\n")
        f.write("    .valid_in_bias(valid_in_bias),\n")
        f.write("    .valid_pipeline(valid_pipeline_bias),\n")
        if (max[z]):
            f.write("    .o_data(i_CORE_IP2[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "])\n")
        else:
            f.write("    .o_data(o_data[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "])\n")
        f.write(");\n")
        f.write("\n")

        if (max[z]):
            f.write("  MaxPooling #(\n")
            f.write("    .DATA_WIDTH(DATA_WIDTH),\n")
            f.write("    .WIDTH(WIDTH)\n")
            f.write("  ) maxpooling" + str(i+1) + "(\n")
            f.write("    .i_data(i_CORE_IP2[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "]),\n")
            f.write("    .valid_in(valid_in_maxpooling), \n")
            f.write("    .valid_in_max(valid_in_max), \n")
            f.write("    .valid_in_max1(valid_in_max1), \n")
            f.write("    .clk(clk), \n")
            f.write("    .rst(rst),\n")
            if (z != 13):
                f.write("    .o_data(o_data[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "])\n")
                f.write("  );\n")
                f.write("\n")
            else:
                f.write("    .o_data(i_CORE_IP3[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "])\n")
                f.write("  );\n")
                f.write("\n")
                f.write("  MaxPooling3x3 #(\n")
                f.write("    .DATA_WIDTH(DATA_WIDTH),\n")
                f.write("    .WIDTH(3)\n")
                f.write("  ) maxpooling3x3" + str(i+1) + "(\n")
                f.write("    .i_data(i_CORE_IP3[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "]),\n")
                f.write("    .valid_in(valid_in_maxpooling3x3), \n")
                f.write("    .valid_in_max(valid_in_max3x3), \n")
                f.write("    .valid_in_max1(valid_in_max13x3), \n")
                f.write("    .clk(clk), \n")
                f.write("    .rst(rst),\n")
                f.write("    .o_data(o_data[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "])\n")
                f.write("  );\n")
                f.write("\n")

    f.write("  control_layer" + str(control_layer) + "#(\n")
    f.write("      .WIDTH(WIDTH)\n")
    f.write("    )control( \n")
    f.write("      .clk(clk), \n")
    f.write("      .rst(rst),\n")
    f.write("      .valid_in(valid_in), \n")
    f.write("      .padding_valid(padding_valid), \n")
    f.write("      .counter_col(counter_col), \n")
    f.write("      .counter_row(counter_row), \n")
    f.write("      .valid_in_pipeline2D(valid_in_pipeline2D),\n")
    f.write("      .valid_pipeline2D(valid_pipeline2D),\n")
    f.write("      .valid_in_bias(valid_in_bias),\n")
    f.write("      .valid_pipeline_bias(valid_pipeline_bias),\n")
    if (max[z]):
        f.write("      .valid_in_maxpooling(valid_in_maxpooling), \n")
        f.write("      .valid_in_max(valid_in_max), \n")
        f.write("      .valid_in_max1(valid_in_max1),\n")
        if z == 13:
          f.write("      .valid_in_maxpooling3x3(valid_in_maxpooling3x3),\n")
          f.write("      .valid_in_max3x3(valid_in_max3x3),\n")
          f.write("      .valid_in_max13x3(valid_in_max13x3),\n")
    f.write("      .valid_out(valid_out)\n")
    f.write("    );\n")
    f.write("endmodule\n")
    f.close()