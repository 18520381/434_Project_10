import os
import glob

def getpath(name):
    return os.path.abspath(os.path.join(os.path.dirname(__file__), name))


# # Make input ==
os.system('python3 {:s}'.format(getpath('Make_input.py')))

# # Make Top module of each layer
os.system('python3 {:s}'.format(getpath('Script_1_13.py')))
os.system('python3 {:s}'.format(getpath('Script_FC.py')))

# # Compile module verilog and testbench

command = ['vlog']
command.extend(glob.glob(getpath('../RTL/core/*.v')))
command.extend(glob.glob(getpath('../RTL/tb/*.v')))

command = ' '.join(command)

os.system(command)

# # Run simulation

os.system('vsim -c -do "run -all" layer1_tb')
os.system('vsim -c -do "run -all" layer2_tb')
os.system('vsim -c -do "run -all" layer3_tb')
os.system('vsim -c -do "run -all" layer4_tb')
os.system('vsim -c -do "run -all" layer5_tb')
os.system('vsim -c -do "run -all" layer6_tb')
os.system('vsim -c -do "run -all" layer7_tb')
os.system('vsim -c -do "run -all" layer8_tb')
os.system('vsim -c -do "run -all" layer9_tb')
os.system('vsim -c -do "run -all" layer10_tb')
os.system('vsim -c -do "run -all" layer11_tb')
os.system('vsim -c -do "run -all" layer12_tb')
os.system('vsim -c -do "run -all" layer13_tb')
os.system('vsim -c -do "run -all" layer14_tb')
os.system('vsim -c -do "run -all" layer15_tb')


# Simulation with wave

# os.system('vsim -c -wlf {:s} -do "do {:s}; run -all" layer1_tb'.format(getpath('../Data_out/orange0/orange0.wlf'), getpath('../Data_out/rrange0/command.do')))
# os.system('vsim -view {:s} -do "do {:s}"'.format(getpath('../Data_out/orange0/orange0.wlf'), getpath('../Data_out/rrange0/command.do')))

# # Compare RTL and Keras
os.system('python3 {:s}'.format(getpath('Compare.py')))