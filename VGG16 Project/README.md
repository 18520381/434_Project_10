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
![alt text](https://github.com/18520381/434_Project_10/blob/48a5569a74f4b07e021871bff6f7e5a8898e93c9/VGG16%20Project/PNG/Layer112x112.png)

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


The smaller the result, the more accurate is

## Layer1 (Conv1)
![alt text](https://github.com/18520381/434_Project_10/blob/4d90d9eb0c8d171591f2f7fe538446db9811eea9/VGG16%20Project/PNG/KERAS_Layer1.png)
![alt text](https://github.com/18520381/434_Project_10/blob/e20891091c9c18cbb1f419b18644ac9cc4972478/VGG16%20Project/PNG/RTL_Layer1.png)

## Layer2 (Conv2 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/4d90d9eb0c8d171591f2f7fe538446db9811eea9/VGG16%20Project/PNG/KERAS_Layer2.png)
![alt text](https://github.com/18520381/434_Project_10/blob/e20891091c9c18cbb1f419b18644ac9cc4972478/VGG16%20Project/PNG/RTL_Layer2.png)

# Layer3 (Conv3)
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/KERAS_Layer3.png)
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/RTL_Layer3.png)
Mean square error: 3.5145720920190036e-16

# Layer4 (Conv4 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/979e52e331208d408b6704f9e3e2a34c4f74831d/VGG16%20Project/PNG/KERAS_Layer4.png)
![alt text](https://github.com/18520381/434_Project_10/blob/979e52e331208d408b6704f9e3e2a34c4f74831d/VGG16%20Project/PNG/RTL_Layer4.png)
Mean square error: 3.76737488767457e-16

# Layer5 (Conv5)
![alt text](https://github.com/18520381/434_Project_10/blob/7ec3dffb0ff4c6b286b77d185b9e78aa8ca2de55/VGG16%20Project/PNG/KERAS_Layer5.png)
![alt text](https://github.com/18520381/434_Project_10/blob/7ec3dffb0ff4c6b286b77d185b9e78aa8ca2de55/VGG16%20Project/PNG/RTL_Layer5.png)
Mean square error: 1.5335775032011443e-16

# Layer6 (Conv6)
![alt text](https://github.com/18520381/434_Project_10/blob/55753cb2af635b66c6f9924b137d058a14f7ef6b/VGG16%20Project/PNG/KERAS_Layer6.png)
![alt text](https://github.com/18520381/434_Project_10/blob/55753cb2af635b66c6f9924b137d058a14f7ef6b/VGG16%20Project/PNG/RTL_Layer6.png)
Mean square error: 5.270432605347058e-17

# Layer7 (Conv7 + Maxpooling)
![alt text](https://github.com/18520381/434_Project_10/blob/56949575bcd362f23216e8484c5a751ca7a2cc87/VGG16%20Project/PNG/KERAS_Layer7.png)
![alt text](https://github.com/18520381/434_Project_10/blob/56949575bcd362f23216e8484c5a751ca7a2cc87/VGG16%20Project/PNG/RTL_Layer7.png)
Mean square error: 5.000144607958044e-17

# Layer8 (Conv8)
![alt text](https://github.com/18520381/434_Project_10/blob/8c5ce3d6e93e21910c8bb5117e0a2a64455e809e/VGG16%20Project/PNG/KERAS_Layer8.png)
![alt text](https://github.com/18520381/434_Project_10/blob/8c5ce3d6e93e21910c8bb5117e0a2a64455e809e/VGG16%20Project/PNG/RTL_Layer8.png)
Mean square error: 2.3982787150238187e-17

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
