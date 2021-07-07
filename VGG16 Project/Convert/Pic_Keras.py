from tensorflow import keras
import cv2

base_model = keras.models.load_model('/content/drive/MyDrive/ColabNotebooks/data/model6.h5')

path = '/content/drive/MyDrive/ColabNotebooks/data/Lenna.png'
x = cv2.imread(path)
x = cv2.resize(x,(112,112))
x = cv2.cvtColor(x, cv2.COLOR_BGR2RGB)
x = x / 255.0
x.shape

conv1 = base_model.layers[0]
conv2 = base_model.layers[1]
y = conv1(x[np.newaxis,:,:,:])
z = conv2(y)

y = y.numpy()
y = y.squeeze()

z = z.numpy()
z = z.squeeze()

feature_map_show(y, "KERAS_Layer1")