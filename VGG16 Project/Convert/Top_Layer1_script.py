from tensorflow import keras
import cv2
import sys
import numpy
import re
import struct
numpy.set_printoptions(threshold=sys.maxsize)


base_model = keras.models.load_model('/content/drive/MyDrive/ColabNotebooks/data/model6.h5') 

kernel1 = base_model.layers[0].get_weights()[0]
bias1   = base_model.layers[0].get_weights()[1]

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

kernel = 3
conv2d = 3
layer = 8

f = open('/content/drive/MyDrive/ColabNotebooks/data/Layer1.v', 'w')

f.write("module layer1_1#(\n")
f.write("    parameter DATA_WIDTH = 32,\n")
f.write("    parameter WIDTH = 112\n")
f.write(")(\n")
f.write("  input  [DATA_WIDTH*3-1:0] i_data,\n")
f.write("  input              clk, rst, empty, full_fifo_out,\n")
f.write("  output [DATA_WIDTH*" + str(layer) + "-1:0] o_data,\n")
f.write("  output             valid_out, rd_req_FIFO_IN    \n")       
f.write(");\n")
f.write("  wire [DATA_WIDTH-1:0] o_CORE_IP1 [" + str(layer-1) + ":0];\n")
f.write("  wire [DATA_WIDTH-1:0] o_CORE_IP2 [" + str(layer-1) + ":0];\n")
f.write("  wire [DATA_WIDTH-1:0] o_CORE_IP3 [" + str(layer-1) + ":0];\n")
f.write("  wire En, valid_in_line, valid_in_pipeline2D, valid_in_bias; \n")
f.write("  wire [3:0] valid_pipeline2D;\n")
f.write("  wire [1:0] valid_pipeline_bias;\n")
f.write("\n")
for i in range(0, layer):
  f.write("/// CON3d_" + str(i+1) + "///////////////////\n")
  for j in range(0, conv2d):
    f.write("  Con2D #(\n")
    f.write("      .DATA_WIDTH(DATA_WIDTH),\n")
    f.write("      .WIDTH(WIDTH+2),\n")
    for k in range(0, kernel):
      for l in range(0, kernel):
        f.write("      .k" + str(k*3+l+1) + "(32'b" + binary(kernel1[k][l][j][i]) + ")")
        if (k*3+l) != 8:
          f.write(",\n")
        else:
          f.write("\n")
    f.write("  ) CON2D_" + str(i*3+j+1) + "(\n")
    if j == 0:
      f.write("      .i_data(i_data[31:0]),\n")
    elif j == 1:
      f.write("      .i_data(i_data[63:32]),\n")
    else:
      f.write("      .i_data(i_data[95:64]),\n")
    f.write("      .clk(clk), \n")
    f.write("      .rst(rst), \n")
    f.write("      .En(En),\n")
    f.write("      .valid_in_line(valid_in_line),\n")
    f.write("      .valid_in_pipeline2D(valid_in_pipeline2D),\n")
    f.write("      .valid_pipeline2D(valid_pipeline2D),\n")
    f.write("      .o_data(o_CORE_IP" + str(j+1) + "[" + str(i) + "])\n")
    f.write("  );\n")
    f.write("\n")  
  f.write("\n")  
  f.write("pipeline_bias#(\n")
  f.write("    .DATA_WIDTH(DATA_WIDTH),\n")
  f.write("    .bias(32'b" + binary(bias1[i]) + ")\n")
  f.write(")   op" + str(i) + "(\n")
  f.write("    .o_CORE_IP1(o_CORE_IP1[" + str(i) + "]), \n")
  f.write("    .o_CORE_IP2(o_CORE_IP2[" + str(i) + "]), \n") 
  f.write("    .o_CORE_IP3(o_CORE_IP3[" + str(i) + "]), \n")
  f.write("    .clk(clk),\n") 
  f.write("    .rst(rst),\n")
  f.write("    .valid_in_bias(valid_in_bias),\n")
  f.write("    .valid_pipeline(valid_pipeline_bias),\n")
  f.write("    .o_data(o_data[DATA_WIDTH*" + str(i+1) + "-1:DATA_WIDTH*" + str(i) + "])\n")
  f.write(");\n")
  f.write("\n")
f.write("  control_layer1#(\n")
f.write("      .WIDTH(WIDTH+2)\n")
f.write("    )control( \n")
f.write("      .clk(clk), \n")
f.write("      .rst(rst),\n")
f.write("      .empty(empty),\n")
f.write("      .full_fifo_out(full_fifo_out),\n")
f.write("      .valid_in_line(valid_in_line), \n")
f.write("      .En(En), \n")
f.write("      .rd_req_FIFO_IN(rd_req_FIFO_IN),\n")
f.write("      .valid_in_pipeline2D(valid_in_pipeline2D),\n")
f.write("      .valid_pipeline2D(valid_pipeline2D),\n")
f.write("      .valid_in_bias(valid_in_bias),\n")
f.write("      .valid_pipeline_bias(valid_pipeline_bias),\n")
f.write("      .valid_out(valid_out)\n")
f.write("    );\n")
f.write("endmodule\n")
f.close()