import pandas as pd
import numpy as np
from sklearn.utils import shuffle
from sklearn.model_selection import KFold

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

def SBA(data, label, w1, w2, lr, steps):
    for step in range(steps):
        data = shuffle(np.array(Scale(data)),random_state =step)
        label= shuffle(np.array(label),random_state =step)
        a1 = data @ w1   #  (546, 10) @ (10, 5)  → （546， 5）
        z1 = np.tanh(a1)
        yk = z1 @ w2    #  (546, 5) @ (0, 2)  → （546， 2）
        delta_k  = yk - label
        delta_j = (1 - (z1 ** 2))*(delta_k @ w2.T)
        w1 -= lr * (data.T  @ delta_j)
        w2 -= lr * (z1.T @ delta_k)
    return w1, w2

def Acc(data, label, w1, w2):
    a1 = np.array(Scale(data)) @ w1
    z1 = np.tanh(a1)
    yk = z1 @ w2
    return np.mean(np.equal(np.argmax(yk,1),np.argmax(Onehot(label,2),1)))

train_Acc = []
test_Acc = []
D = 10 # number of input feature
K = 2  # number of label class
# Initialize hyperparameters
H = 5  # number of hidden layers
T = 100 # number of training times
lr = 0.001 # study rate
for i in range(5):
    # Initialize w
    w1 = get_w([D, H],D,K)
    w2 = get_w([H, K],D,K)
    #training
    w1, w2 = SBA(data_train[i], Onehot(label_train[i],2), w1, w2, lr, T)
    train_Acc.append(Acc(data_train[i], label_train[i], w1, w2))
    test_Acc.append(Acc(data_test[i], label_test[i], w1, w2))
print('Training dataset accuracy: {:.2f}%,Testing dataset accuracy: {:.2f}%'.format(np.mean(np.array(train_Acc))*100 ,np.mean(np.array(test_Acc))*100))