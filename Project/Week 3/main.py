import os
# Run RGB2Binary.py to convert RGB Image to Binary txt file
os.system('python3 /home/pc/Python/Convert_RGB_Binary.py')

# Compile module verilog and testbench
os.system('vlog /home/pc/FPGA/Convert.v /home/pc/FPGA/testbench11.v')

# Run simulation
os.system('vsim -c -do "run -all" testbench11')

# Convert Binary to Decimal and display result
os.system('python3 /home/pc/Python/Processing.py')