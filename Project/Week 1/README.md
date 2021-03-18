# Setup Environment
- Create Github Repository: [This is my repository](https://github.com/18520381/434_Project_10)
- Install Ubuntu Destop: [How to install dual boot](https://quantrimang.com/cach-cai-ubuntu-song-song-voi-windows-bang-usb-148331)
- Install Python 3.6 or later: [How to install Python in Ubuntu](https://phoenixnap.com/kb/install-pip-windows)
- Install OpenCV for Python : [How to install OpenCV in Ubuntu](https://docs.opencv.org/master/d2/de6/tutorial_py_setup_in_ubuntu.html?fbclid=IwAR35GtZdqDXTJJInN_cqtHezxizclsA4ULvCqrVVEjCpeZ4-ScbQuCt9l7I)
- Install ModelSim : [How to install ModelSim in Ubuntu](https://www.youtube.com/watch?v=5y1zwylqgUM)
- Install Vivado : [How to install Vivado in Ubuntu](https://github.com/18520381/434_Project_10/blob/main/Project/Week%201/Vivado_Install_Guide.pdf)

# Write a "Hello World" app

The below code is OpenCV.py in the directory 

```python
import cv2
import numpy as np

pro = cv2.VideoCapture(0)
if (pro.isOpened() == False): 
  print("Unable to read camera feed")

frame_width = int(pro.get(3))
frame_height = int(pro.get(4))

out = cv2.VideoWriter('outpy.avi',cv2.VideoWriter_fourcc('M','J','P','G'), 10, (frame_width,frame_height))


while(True):
  ret, frame = pro.read()
  if ret == True: 
    out.write(frame)
    cv2.imshow('frame',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
      break

  else:
    break 

pro.release()
out.release()

cv2.destroyAllWindows()
```
