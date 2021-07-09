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
[link 1](https://www.kaggle.com/kritikseth/fruit-and-vegetable-image-recognition)

[link 2](https://www.kaggle.com/olgabelitskaya/tomato-cultivars)

[link 3](https://www.kaggle.com/moltean/fruits)

## Top model
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/TopModel.png)

## Layer
![alt text](https://github.com/18520381/434_Project_10/blob/2f126a0307debdbcf69e54d4efa48217cef367b6/VGG16%20Project/PNG/Layer.png)

## Convulution
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/Conv3x3.png)

## ReLU
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/ReLU.png)

## Max Pooling  
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/Max_Pooling.png)

## FC
![alt text](https://github.com/18520381/434_Project_10/blob/main/VGG16%20Project/PNG/FC.png)

# Mean square error (calculate error)
[Wiki about the Mean square error](https://en.wikipedia.org/wiki/Mean_squared_error)


![alt text](https://github.com/18520381/434_Project_10/blob/3ddc6cf3ec1944ce13b4ee0afa98a33d40a207d5/VGG16%20Project/PNG/MSE.png)


The smaller result, the more accurate is

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
![alt text]()
![alt text]()
Mean square error: 

# Layer5 (Conv5)
![alt text]()
![alt text]()
Mean square error: 

# Layer6 (Conv6)
![alt text]()
![alt text]()
Mean square error: 

# Layer7 (Conv7 + Maxpooling)
![alt text]()
![alt text]()
Mean square error: 

# Layer8 (Conv8)
![alt text]()
![alt text]()
Mean square error: 

# Layer9 (Conv9)
![alt text]()
![alt text]()
Mean square error: 

# Layer10 (Conv10 + Maxpooling)
![alt text]()
![alt text]()
Mean square error: 

# Layer11 (Conv11)
![alt text]()
![alt text]()
Mean square error: 

# Layer12 (Conv12)
![alt text]()
![alt text]()
Mean square error: 

# Layer13 (Conv13 + Maxpooling)
![alt text]()
![alt text]()
Mean square error: 

# Layer14 (FC)
![alt text]()
![alt text]()
Mean square error: 

# Layer15 (FC)
![alt text]()
![alt text]()
Mean square error: 
