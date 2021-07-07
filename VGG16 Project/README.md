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
![alt text](https://github.com/18520381/434_Project_10/blob/8d453d747b0485284dd025cddffb31557d99a172/VGG16%20Project/PNG/Layer.png)

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
The MSE either assesses the quality of a predictor (i.e., a function mapping arbitrary inputs to a sample of values of some random variable), or of an estimator (i.e., a mathematical function mapping a sample of data to an estimate of a parameter of the population from which the data is sampled). The definition of an MSE differs according to whether one is describing a predictor or an estimator.
If a vector of {\displaystyle n}n predictions is generated from a sample of n data points on all variables, and {\displaystyle Y}Y is the vector of observed values of the variable being predicted, with {\displaystyle {\hat {Y}}}\hat{Y} being the predicted values (e.g. as from a least-squares fit), then the within-sample MSE of the predictor is computed as
Formula: {\displaystyle \operatorname {MSE} ={\frac {1}{n}}\sum _{i=1}^{n}(\ Y_{i}-{\hat {Y_{i}}})^{2}}


## Layer1
![alt text](https://github.com/18520381/434_Project_10/blob/4d90d9eb0c8d171591f2f7fe538446db9811eea9/VGG16%20Project/PNG/KERAS_Layer1.png)
![alt text](https://github.com/18520381/434_Project_10/blob/e20891091c9c18cbb1f419b18644ac9cc4972478/VGG16%20Project/PNG/RTL_Layer1.png)

## Layer2
![alt text](https://github.com/18520381/434_Project_10/blob/4d90d9eb0c8d171591f2f7fe538446db9811eea9/VGG16%20Project/PNG/KERAS_Layer2.png)
![alt text](https://github.com/18520381/434_Project_10/blob/e20891091c9c18cbb1f419b18644ac9cc4972478/VGG16%20Project/PNG/RTL_Layer2.png)

# Layer3
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/KERAS_Layer3.png)
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/RTL_Layer3.png)
Mean square error: 3.5145720920190036e-16

# Layer4
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/KERAS_Layer3.png)
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/RTL_Layer3.png)
Mean square error: 3.5145720920190036e-16

# Layer5
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/KERAS_Layer3.png)
![alt text](https://github.com/18520381/434_Project_10/blob/427899418f574cbb64091cf5e243472674495479/VGG16%20Project/PNG/RTL_Layer3.png)
Mean square error: 3.5145720920190036e-16


