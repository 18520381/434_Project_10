# Setup Environment
- Create Github Repository
- Install Ubuntu Destop
- Install Python 3.6 or later
- Install OpenCV for Python

# Write a "Hello World" app
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
