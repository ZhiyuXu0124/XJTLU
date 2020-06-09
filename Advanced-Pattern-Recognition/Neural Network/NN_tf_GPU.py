import pandas as pd
import numpy as np
from sklearn.utils import shuffle
from sklearn.model_selection import KFold
import tensorflow as tf

columnNames = [
    'Sample code number',
    'Clump Thickness',
    'Uniformity of Cell Size',
    'Uniformity of Cell Shape',
    'Marginal Adhesion',
    'Single Epithelial Cell Size',
    'Bare Nuclei',
    'Bland Chromatin',
    'Normal Nucleoli',
    'Mitoses',
    'Class'
]
data = pd.read_csv('breast-cancer-wisconsin.data', names = columnNames)

#Replace ？ with NaN
data = data.replace(to_replace='?',value = np.nan)
#Discard data with missing values (discard as long as one dimension is missing)
data = data.dropna(how='any')

#shuffer data
data_shuffled = shuffle(data,random_state = 17).reset_index(drop=True)

#Split dataset into data and label
data, label =data_shuffled[columnNames[1:10]], data_shuffled[columnNames[10]]
data['Extra features'] = 1
data =data.astype('int')
data_list = data.values.tolist()
label =label.astype('int')
label_list = label.values.tolist()

#cross-fold validation
kf = KFold(n_splits=5)
data_train_index,data_test_index = [],[]
for train_index, test_index in kf.split(data):
    data_train_index.append(train_index)
    data_test_index.append(test_index)
data_train, label_train = [], []
data_test,label_test = [],[]
for i in range(5):
    temp = []
    for j in range(len(data_train_index[i])):
        temp.append(data_list[data_train_index[i][j]])
    data_train.append(temp)
    temp = []
    for j in range(len(data_train_index[i])):
        temp.append(label_list[data_train_index[i][j]])
    label_train.append(temp)

    temp = []
    for k in range(len(data_test_index[i])):
        temp.append(data_list[data_test_index[i][k]])
    data_test.append(temp)
    temp = []
    for k in range(len(data_test_index[i])):
        temp.append(label_list[data_test_index[i][k]])
    label_test.append(temp)

def Scale(data):
    arr =  np.array(data)
    new_data = []
    for i in range(len(arr)):
        tmp = []
        for j in range(len(arr[i])):
            tmp.append(2*((arr[i][j]-np.min(arr[i])+1E-6)/(np.max(arr[i])-np.min(arr[i])+1E-6))-1)
        new_data.append(tmp)
    return new_data

def Onehot(label,num):
    length = len(label)
    t_nk = np.zeros((length,num),dtype='int')
    for i in range(length):
        if label[i] == 2:
            t_nk[i][0] = 1
        elif label[i] == 4:
            t_nk[i][1] = 1
    return t_nk

def get_w(size, D, K, seed = 666):
    np.random.seed(seed)
    w = np.random.random(size)  # w → [0,1]
    w = 2*w -1 # w → [-1,1]
    w = w * np.sqrt(6/(D+K+1)) # w → [-sqrt(6/(D+K+1)),sqrt(6/(D+K+1))]  
    return w

x = tf.placeholder(tf.float64, [None, 10], name="input_x")
label = tf.placeholder(tf.float64, [None, 2], name="input_y")

W1 = tf.Variable((np.random.random([10, 50])*2 - 1)*np.sqrt(6/(13)))
W2 = tf.Variable((np.random.random([50, 2])*2 - 1)*np.sqrt(6/(13)))

h = tf.matmul(x, W1)
h = tf.nn.tanh(h) # 非线性特征
y = tf.matmul(h, W2)

loss = tf.reduce_mean(tf.square(y-label))
train_step = tf.train.GradientDescentOptimizer(0.1).minimize(loss)
correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(label, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

for i in range(5):
    sess = tf.Session()
    sess.run(tf.global_variables_initializer())
    Acc = []
    for itr in range(2001):
        sess.run(train_step, feed_dict={x: data_train[i], label: label_train[i]})
        if itr % 200 == 0:
            print("group%1d"%(i+1),"step:%6d  train accuracy:"%itr, sess.run(accuracy, feed_dict={x: data_train[i],
                                            label: label_train[i]}),
                  "test accuracy:",sess.run(accuracy, feed_dict={x: data_test[i], label: label_test[i]}))
    Acc.append(sess.run(accuracy, feed_dict={x: data_test[i],
                                            label: label_test[i]}))