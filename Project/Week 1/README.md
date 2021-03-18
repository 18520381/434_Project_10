# Setup Environment
- Create Github Repository: https://github.com/18520381/434_Project_10
- Install Ubuntu Destop: https://ubuntu.com/download/desktop
- Install Python 3.6 or later: https://phoenixnap.com/kb/install-pip-windows
- Install OpenCV for Python : https://docs.opencv.org/master/d2/de6/tutorial_py_setup_in_ubuntu.html?fbclid=IwAR35GtZdqDXTJJInN_cqtHezxizclsA4ULvCqrVVEjCpeZ4-ScbQuCt9l7I

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
