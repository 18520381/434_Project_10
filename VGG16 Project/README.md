# Project Image Classification using VGG 16
## Some fact about VGG 16

![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/VGG16.png)

- It is also called the OxfordNet model, named after the Visual Geometry Group from Oxford.
- Number 16 refers that it has a total of 16 layers that has some weights.
- It Only has Conv and pooling layers in it.
- Always use a 3 x 3 Kernel for convolution.
- 2x2 size of the max pool.
- Has a total of about 138 million parameters.
- Trained on ImageNet data
- It has an accuracy of 92.7%.
- it has one more version of it Vgg 19, a total of 19 layers with weights.
## Get data from kaggle
[link](https://www.kaggle.com/jorgebailon/fruits-vegetables)

## Top model
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/TopModel.png)

## Layer
![alt text](https://github.com/18520381/434_Project_10/blob/2f126a0307debdbcf69e54d4efa48217cef367b6/VGG16%20Project/PNG/Layer.png)

## Convulution
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/CON3D.png)
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/CON2D.png)

## ReLU
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/ReLU.png)

## Max Pooling  
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/Max%20Pooling.png)

## FC
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/FC.png)
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/FC%20Node.png)

# Mean square error (calculate error)
[Wiki about the Mean square error](https://en.wikipedia.org/wiki/Mean_squared_error)


![alt text](https://github.com/18520381/434_Project_10/blob/3ddc6cf3ec1944ce13b4ee0afa98a33d40a207d5/VGG16%20Project/PNG/MSE.png)


The smaller result, the more accurate is

## Input
![alt text](https://github.com/18520381/434_Project_10/blob/5788f01266173b0753b1b010c480edbd33d51f88/VGG16%20Project/PNG/Input.png)

## Layer1 (Conv1)
![alt text](https://github.com/18520381/434_Project_10/blob/b95783b5ddb928a6545d5117af15a1bb8c4aaca4/VGG16%20Project/PNG/KERAS_Layer1.png)
![alt text](https://github.com/18520381/434_Project_10/blob/093a35e62458e6c83fb901e4386a5c6645018c2e/VGG16%20Project/PNG/RTL_Layer1.png)
Mean square error: 7.99773288183833e-06

## Layer2 (Conv2 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/b95783b5ddb928a6545d5117af15a1bb8c4aaca4/VGG16%20Project/PNG/KERAS_Layer2.png)
![alt text](https://github.com/18520381/434_Project_10/blob/b95783b5ddb928a6545d5117af15a1bb8c4aaca4/VGG16%20Project/PNG/RTL_Layer2.png)
Mean square error: 4.4917954161823246e-05

# Layer3 (Conv3)
![alt text](https://github.com/18520381/434_Project_10/blob/6e2b546d751824012b147fe4c7fcc0226d0dec99/VGG16%20Project/PNG/KERAS_Layer3.png)
![alt text](https://github.com/18520381/434_Project_10/blob/6e2b546d751824012b147fe4c7fcc0226d0dec99/VGG16%20Project/PNG/RTL_Layer3.png)
Mean square error: 7.23422541465922e-15

# Layer4 (Conv4 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/57012b99d8297f8f712c85c08968d3e0daa39f88/VGG16%20Project/PNG/KERAS_Layer4.png)
![alt text](https://github.com/18520381/434_Project_10/blob/57012b99d8297f8f712c85c08968d3e0daa39f88/VGG16%20Project/PNG/RTL_Layer4.png)
Mean square error: 6.8960714185873534e-15

# Layer5 (Conv5)
![alt text](https://github.com/18520381/434_Project_10/blob/27c5a0db13b5a05a56e1b37f90d4dcccc912c164/VGG16%20Project/PNG/KERAS_Layer5.png)
![alt text](https://github.com/18520381/434_Project_10/blob/27c5a0db13b5a05a56e1b37f90d4dcccc912c164/VGG16%20Project/PNG/RTL_Layer5.png)
Mean square error: 3.2191558913759888e-15

# Layer6 (Conv6)
![alt text](https://github.com/18520381/434_Project_10/blob/2faee59a50d37b32e1652ffb9803a0a2706fda8d/VGG16%20Project/PNG/KERAS_Layer6.png)
![alt text](https://github.com/18520381/434_Project_10/blob/2faee59a50d37b32e1652ffb9803a0a2706fda8d/VGG16%20Project/PNG/RTL_Layer6.png)
Mean square error: 5.3457293917565884e-15

# Layer7 (Conv7 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/5cc219d4a94383e8f55b9df902860316532bf7bf/VGG16%20Project/PNG/KERAS_Layer7.png)
![alt text](https://github.com/18520381/434_Project_10/blob/5cc219d4a94383e8f55b9df902860316532bf7bf/VGG16%20Project/PNG/RTL_Layer7.png)
Mean square error: 8.079416092229458e-15

# Layer8 (Conv8)
![alt text](https://github.com/18520381/434_Project_10/blob/ae709e7618313571a88bd9c0d1b28d0a50b50b19/VGG16%20Project/PNG/KERAS_Layer8.png)
![alt text](https://github.com/18520381/434_Project_10/blob/ae709e7618313571a88bd9c0d1b28d0a50b50b19/VGG16%20Project/PNG/RTL_Layer8.png)
Mean square error: 4.496632259782603e-15

# Layer9 (Conv9)
![alt text](https://github.com/18520381/434_Project_10/blob/a5f823bf8d625b6cd82cd13517bd970f1a1fd48a/VGG16%20Project/PNG/KERAS_Layer9.png)
![alt text](https://github.com/18520381/434_Project_10/blob/a5f823bf8d625b6cd82cd13517bd970f1a1fd48a/VGG16%20Project/PNG/RTL_Layer9.png)
Mean square error: 7.0192610813981836e-15

# Layer10 (Conv10 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/b1ce7bb528359eded28e2c5cda2ccad9293e813f/VGG16%20Project/PNG/KERAS_Layer10.png)
![alt text](https://github.com/18520381/434_Project_10/blob/b1ce7bb528359eded28e2c5cda2ccad9293e813f/VGG16%20Project/PNG/RTL_Layer10.png)
Mean square error: 1.9312641055529875e-14

# Layer11 (Conv11)
![alt text](https://github.com/18520381/434_Project_10/blob/6418b2b9c3a66e94cbf3e1bdaacc4abb7be9c1bb/VGG16%20Project/PNG/KERAS_Layer11.png)
![alt text](https://github.com/18520381/434_Project_10/blob/6418b2b9c3a66e94cbf3e1bdaacc4abb7be9c1bb/VGG16%20Project/PNG/RTL_Layer11.png)
Mean square error: 5.5163073655425093e-14

# Layer12 (Conv12)
![alt text](https://github.com/18520381/434_Project_10/blob/6418b2b9c3a66e94cbf3e1bdaacc4abb7be9c1bb/VGG16%20Project/PNG/KERAS_Layer12.png)
![alt text](https://github.com/18520381/434_Project_10/blob/6418b2b9c3a66e94cbf3e1bdaacc4abb7be9c1bb/VGG16%20Project/PNG/RTL_Layer12.png)
Mean square error: 4.4412567444557807e-14

# Layer13 (Conv13 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/b94c52aaa308acc8df68466ca687143e60e9ffea/VGG16%20Project/PNG/KERAS_Layer13.png)
![alt text](https://github.com/18520381/434_Project_10/blob/b94c52aaa308acc8df68466ca687143e60e9ffea/VGG16%20Project/PNG/RTL_Layer13.png)
Mean square error: 1.786391732841144e-13

# Flating
![alt text](https://github.com/18520381/434_Project_10/blob/849f7d04332cb0c63bb87f68068f269dada6d114/VGG16%20Project/PNG/Flating.png)


Mean square error: 1.6182194473302047e-13

# Layer14 (FC1)
![alt text](https://github.com/18520381/434_Project_10/blob/91a640a9237b0e29181444d569ed28ebdcc59018/VGG16%20Project/PNG/FC1.png)


Mean square error: 1.0658141036401503e-13

# Layer15 (FC2)
![alt text](https://github.com/18520381/434_Project_10/blob/771d280413ff2de20b9cb98d59f4b83619a69847/VGG16%20Project/PNG/FC2.png)


Mean square error: 3.5128150388530344e-17
