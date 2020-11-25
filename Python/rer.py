from PIL import Image
import numpy as np
import os
from random import shuffle
import matplotlib.pyplot as plt
DIR = './train1'

# Want to know how we should format the height x width image data dimensions
# for inputting to a keras model
'''def get_size_statistics():
    heights = []
    widths = []
    img_count = 0
    for img in os.listdir(DIR):
        path = os.path.join(DIR, img)
        if "DS_Store" not in path:
            data = np.array(Image.open(path))
            heights.append(data.shape[0])
            widths.append(data.shape[1])
            img_count += 1
    avg_height = sum(heights) / len(heights)
    avg_width = sum(widths) / len(widths)
    print("Average Height: " + str(avg_height))
    print("Max Height: " + str(max(heights)))
    print("Min Height: " + str(min(heights)))
    print('\n')
    print("Average Width: " + str(avg_width))
    print("Max Width: " + str(max(widths)))
    print("Min Width: " + str(min(widths)))

#get_size_statistics()'''

def label_img(name):
    word_label = name.split('.')[0]
    if word_label == 'cat': return np.array([1, 0])
    elif word_label == 'dog' : return np.array([0, 1])

IMG_SIZE = 300

def load_training_data():
    train_data = []
    for img in os.listdir(DIR):
        label = label_img(img)
        path = os.path.join(DIR, img)
        if "DS_Store" not in path:
            img = Image.open(path)
            img = img.convert('L')
            img = img.resize((IMG_SIZE, IMG_SIZE), Image.ANTIALIAS)
            train_data.append([np.array(img), label])

    shuffle(train_data)
    return train_data

train_data = load_training_data()
plt.imshow(train_data[43][0], cmap = 'gist_gray')
plt.show()

trainImages = np.array([i[0] for i in train_data]).reshape(-1, IMG_SIZE, IMG_SIZE, 1)
trainLabels = np.array([i[1] for i in train_data])

import keras
print('1')
from keras.models import Sequential
print('2')
from keras.layers import Dense, Dropout, Flatten
print('3')
from keras.layers import Conv2D, MaxPooling2D
print('4')
from keras.layers. normalization import BatchNormalization
print('5')

model = Sequential()
print('6')
model.add(Conv2D(32, kernel_size = (3, 3), activation='relu', input_shape=(IMG_SIZE, IMG_SIZE, 1)))
print('7')
model.add(MaxPooling2D(pool_size=(2,2)))
print('8')
model.add(BatchNormalization())
print('9')
model.add(Conv2D(64, kernel_size=(3,3), activation='relu'))
print('10')
model.add(MaxPooling2D(pool_size=(2,2)))
print('11')
model.add(BatchNormalization())
print('12')
model.add(Conv2D(96, kernel_size=(3,3), activation='relu'))
print('13')
model.add(MaxPooling2D(pool_size=(2,2)))
print('14')
model.add(BatchNormalization())
print('15')
model.add(Conv2D(96, kernel_size=(3,3), activation='relu'))
print('16')
model.add(MaxPooling2D(pool_size=(2,2)))
print('17')
model.add(BatchNormalization())
print('18')
model.add(Conv2D(64, kernel_size=(3,3), activation='relu'))
print('19')
model.add(MaxPooling2D(pool_size=(2,2)))
print('20')
model.add(BatchNormalization())
print('21')
model.add(Dropout(0.2))
print('22')
model.add(Flatten())
print('23')
model.add(Dense(256, activation='relu'))
print('24')
model.add(Dropout(0.2))
print('25')
model.add(Dense(128, activation='relu'))
print('26')
#model.add(Dropout(0.3))
model.add(Dense(2, activation = 'softmax'))
print('27')

model.compile(loss='binary_crossentropy', optimizer='adam', metrics = ['accuracy'])
print('28')
model.fit(trainImages, trainLabels, batch_size = 50, epochs = 5, verbose = 1)
print('29')

TEST_DIR = './test1'
def load_test_data():
    test_data = []
    for img in os.listdir(TEST_DIR):
        label = label_img(img)
        path = os.path.join(TEST_DIR, img)
        if "DS_Store" not in path:
            img = Image.open(path)
            img = img.convert('L')
            img = img.resize((IMG_SIZE, IMG_SIZE), Image.ANTIALIAS)
            test_data.append([np.array(img), label])
    shuffle(test_data)
    return test_data


test_data = load_test_data()
print('30')
plt.imshow(test_data[10][0], cmap = 'gist_gray')
plt.show()
print('31')