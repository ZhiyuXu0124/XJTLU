import pandas as pd
import numpy as np
from sklearn.utils import shuffle
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from sklearn.model_selection import KFold

def Scale(data):
    arr =  np.array(data)
    new_data = []
    for i in range(len(arr)):
        tmp = []
        for j in range(len(arr[i])):
            # tmp.append(2*((arr[i][j]-np.min(arr[i])*arr[i][j]+1E-6)/(np.max(arr[i])-np.min(arr[i])*arr[i][j]+1E-6))-1)
            tmp.append(2 * ((arr[i][j] - np.min(arr[i]) + 1E-6) / (np.max(arr[i]) - np.min(arr[i]) + 1E-6)) - 1)
        new_data.append(tmp)
    return new_data

def reset(data,label,num):
    data_new=[]
    for i in range(len(label)):
        if label[i] == num:
            tmp = []
            for j in range(len(data[i])):
                tmp.append(data[i][j]*-1)
            data_new.append(tmp)
        else:
            tmp = []
            for j in range(len(data[i])):
                tmp.append(data[i][j])
            data_new.append(tmp)
    return data_new

# def find_wv(X):
#     X_T =np.transpose(X)
#     w = np.dot(np.dot(np.linalg.inv(np.dot(X_T,X)),X_T),y)
#     return w
def find_wv(X):
    X_T =np.transpose(X)
    one = np.ones([len(X),1])
    k = np.dot(X_T, X)
    w = np.dot(np.dot(np.linalg.inv(k), X_T), one)
    return w

def predict_label(w,x):
    w_T = np.transpose(w)
    label_pre = []
    for i in range(len(x)):
        if np.dot(w_T,np.transpose(x[i])) >= 0:
            label_pre.append(2)
        else:
            label_pre.append(4)
    return label_pre

def acc(predict,original):
    if len(predict)!=len(original):
        print('Error:The length of the predicted value does not match the length of the original value！')
    right = 0
    for i in range(len(predict)):
        if predict[i]==original[i]:
            right+=1
    return right/len(predict)

'''
Read dataset
 Attribute Information: (class attribute has been moved to last column)

| Attribute  | Domain |
|------------- | ------------- |
|Sample code number  | 1 - 10  |
|Clump Thickness| 1 - 10  |
|Uniformity of Cell Size| 1 - 10  |
|Uniformity of Cell Shape  | 1 - 10  |
|Marginal Adhesion  | 1 - 10  |
|Single Epithelial Cell Size  | 1 - 10  |
|Bare Nuclei  | 1 - 10  |
|Bland Chromatin  | 1 - 10  |
|Normal Nucleoli  | 1 - 10  |
|Mitoses  | 1 - 10  |
|Class  | 2 for benign, 4 for malignant  |
'''

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
data_shuffled = shuffle(data,random_state = 17).reset_index(drop=True)
data, label =data_shuffled[columnNames[1:10]], data_shuffled[columnNames[10]]
data['Extra features'] = 1
data1 =data.astype('int')
data_list = data1.values.tolist()
label =label.astype('int')
label_list = label.values.tolist()

mean_Acc = []
plt.figure(figsize=(16,20))
plt.subplots_adjust(wspace =0.2, hspace =0.2)
x = range(1,6)
for z in x:
    num = np.random.randint(1,1000)
    kf = KFold(n_splits=5, shuffle=True, random_state=num)
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
    Acc = []
    for j in x:
        X_train = Scale(data_train[j-1])
        y = label_train[j-1]
        X = reset(X_train,y,4)
        w = find_wv(X)
        X_test = Scale(data_test[j - 1])
        y_pre = predict_label(w,X_test)
        Acc.append(acc(y_pre,label_test[j-1]))
    plt.subplot(3,2,z)
    plt.plot(x,Acc,'-.o')
    def to_percent(temp, position):
        return '%1.0f'%(100*temp) + '%'
    plt.gca().yaxis.set_major_formatter(ticker.FuncFormatter(to_percent))
    plt.xlabel('No.K-Flod')
    plt.ylabel('Accuarcy')
    plt.title('The mean of five accuracies is {:.2%}(random_seed={})'.format(np.mean(np.array(Acc)),num))
    mean_Acc.append(np.mean(np.array(Acc)))
plt.subplot(3,2,6)
plt.plot(x,mean_Acc,'-.o')
plt.gca().yaxis.set_major_formatter(ticker.FuncFormatter(to_percent))
plt.xlabel('K-Flod by different random seed')
plt.ylabel('Accuarcy')
plt.title('The mean of five mean_Acc is {:.2%}'.format(np.mean(mean_Acc)))
plt.show()