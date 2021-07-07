# initial

from google.colab import drive
from torchvision import models
drive.mount('/content/drive')
%cd /content/drive/MyDrive/ColabNotebooks/data

import warnings
warnings.filterwarnings('ignore')

import cv2       
import os

import numpy as np
import pandas as pd
%matplotlib inline
import matplotlib.pyplot as plt
import seaborn as sns

from keras.preprocessing.image import ImageDataGenerator

from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, accuracy_score, recall_score, classification_report
from sklearn.preprocessing import LabelEncoder

from keras.layers import Dense
from keras.layers import Flatten, Activation
from keras.layers import Conv2D, MaxPooling2D, GlobalMaxPooling2D
from keras.optimizers import Adam, RMSprop, SGD
from keras.utils.np_utils import to_categorical    
from keras.models import Sequential
from keras.applications.vgg16 import VGG16
from keras.callbacks import ReduceLROnPlateau

# import data

import random as rn
from tqdm import tqdm

CLASS_NAME = ["apple", "orange"]
DATA_PATH = "../data/train/"
img_size = 112

images = []
labels = []
pbar = tqdm(total=2000)
for class_name in CLASS_NAME:
    for _, _, files in os.walk(DATA_PATH+class_name, topdown=False):
        for name in files:
            image = cv2.imread(DATA_PATH+""+class_name+"/"+name)
            image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            image = cv2.resize(image, (img_size,img_size))

            images.append(np.array(image))
            labels.append(str(class_name))

            pbar.update(1)
pbar.close()

data = np.array(images)
labels = np.array(labels)

le = LabelEncoder()
y = le.fit_transform(labels)
y = to_categorical(y, 2)
X = data / 255.0
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 5)

np.random.seed(50)
rn.seed(50)

# setup vgg16

size = img_size
fil = 8

model = Sequential()
model.add(Conv2D(input_shape=(size,size,3),filters=fil,kernel_size=(3,3),padding="same", activation="relu"))
model.add(Conv2D(filters=fil,kernel_size=(3,3),padding="same", activation="relu"))
model.add(MaxPooling2D(pool_size=(2,2),strides=(2,2)))

model.add(Conv2D(filters=fil*2, kernel_size=(3,3), padding="same", activation="relu"))
model.add(Conv2D(filters=fil*2, kernel_size=(3,3), padding="same", activation="relu"))
model.add(MaxPooling2D(pool_size=(2,2),strides=(2,2)))

model.add(Conv2D(filters=fil*4, kernel_size=(3,3), padding="same", activation="relu"))
model.add(Conv2D(filters=fil*4, kernel_size=(3,3), padding="same", activation="relu"))
model.add(Conv2D(filters=fil*4, kernel_size=(3,3), padding="same", activation="relu"))
model.add(MaxPooling2D(pool_size=(2,2),strides=(2,2)))

model.add(Conv2D(filters=fil*8, kernel_size=(3,3), padding="same", activation="relu"))
model.add(Conv2D(filters=fil*8, kernel_size=(3,3), padding="same", activation="relu"))
model.add(Conv2D(filters=fil*8, kernel_size=(3,3), padding="same", activation="relu"))
model.add(MaxPooling2D(pool_size=(2,2),strides=(2,2)))

model.add(Conv2D(filters=fil*8, kernel_size=(3,3), padding="same", activation="relu"))
model.add(Conv2D(filters=fil*8, kernel_size=(3,3), padding="same", activation="relu"))
model.add(Conv2D(filters=fil*8, kernel_size=(3,3), padding="same", activation="relu"))
model.add(MaxPooling2D(pool_size=(2,2),strides=(2,2)))

model.add(GlobalMaxPooling2D())
model.add(Dense(fil*4,activation='relu'))
model.add(Dense(2,activation="softmax"))

red_lr=ReduceLROnPlateau(monitor='val_acc', factor=0.1, min_delta=0.0001, patience=2, verbose=1)

datagen = ImageDataGenerator(featurewise_center= False,
                              samplewise_center= False,
                              featurewise_std_normalization= False,
                              samplewise_std_normalization=False,
                              rotation_range= 0,        
                              zca_whitening=False,
                              zoom_range=0.1,           
                              width_shift_range=0.1,   
                              height_shift_range=0.1,    
                              horizontal_flip=True,     
                              vertical_flip=False)       
                             
datagen.fit(X_train)

model.save("/content/drive/MyDrive/ColabNotebooks/data/model6.h5")

model.summary()

# train model

import tensorflow as tf
model_checkpoint_callback = tf.keras.callbacks.ModelCheckpoint(
    filepath='/content/drive/MyDrive/ColabNotebooks/data/model6.h5',
    save_weights_only=True,
    monitor='val_accuracy',
    mode='max',
    save_best_only=True)

model.compile(optimizer=Adam(lr = 1e-4), loss= 'categorical_crossentropy', metrics=['accuracy'])

batch_size=32
History = model.fit_generator(datagen.flow(X_train,y_train, batch_size=batch_size),
                              epochs = 5, validation_data = (X_test,y_test),                            
                              verbose = 1, steps_per_epoch= 25, callbacks=[model_checkpoint_callback])
							  
import matplotlib.pyplot as plt
plt.plot(History.history["accuracy"])
plt.plot(History.history['val_accuracy'])
plt.plot(History.history['loss'])
plt.plot(History.history['val_loss'])
plt.title("model accuracy")
plt.ylabel("Accuracy")
plt.xlabel("Epoch")
plt.legend(["Accuracy","Validation Accuracy","loss","Validation Loss"])
plt.show()

# save model

model.save("/content/drive/MyDrive/ColabNotebooks/data/model6.h5")

# test model

import numpy as np
from keras.preprocessing import image
from tensorflow import keras

img_size = 112

path = '/content/drive/MyDrive/ColabNotebooks/data/test/apple/apple_2.jpg'

from keras.preprocessing import image
img = image.load_img(path, target_size = (img_size, img_size))
img = np.asarray(img)
plt.imshow(img)
img = np.expand_dims(img, axis=0)

saved_model = keras.models.load_model('/content/drive/MyDrive/ColabNotebooks/data/model6.h5')
output = saved_model.predict(img)
if output[0][0] > output[0][1]:
    print("apple")
else:
    print("orange")