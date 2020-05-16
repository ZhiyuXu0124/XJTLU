import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

iris = pd.read_table('iris.data.txt', delimiter=',',header = None)
iris_data = iris[[0,1,2,3]]
iris_target = iris[4]

def PCA(data,n):

    X = np.mat(data)
    X_mean = np.mean(X,axis=0)
    X_meanRemoved = X - X_mean
    n_samples,n_features = X.shape
    covMat = np.dot(X_meanRemoved.T, X_meanRemoved)
    eigVals, eigVects = np.linalg.eig(np.mat(covMat))
    eig_pairs = [(np.abs(eigVals[i]), eigVects[:, i]) for i in range(n_features)]
    # sort eig_vec based on eig_val from highest to lowest
    eig_pairs.sort(reverse=True)
    # Compute r eigenvectors with largest eigenvalues
    C = np.array([ele[1] for ele in eig_pairs[:n]])
    # get new data
    Y = np.dot(X, np.transpose(C))
    return  Y

def LDA(data,target,n):
    X = np.mat(data)
    X_K = []
    _ ,n_features = X.shape
    for label, i in zip(['Iris-setosa', 'Iris-versicolor', 'Iris-virginica'], range(n_features)):
        X_K.append(X[iris_target == label])
    mean_class = []
    for label, i in zip(['Iris-setosa', 'Iris-versicolor', 'Iris-virginica'], range(n_features)):
        mean_class.append(np.mean(X_K[i], axis=0))

    d = n_features  # number of features
    S_W = np.zeros((d, d))
    for label, mc in zip(['Iris-setosa', 'Iris-versicolor', 'Iris-virginica'], mean_class):
        class_scatter = np.zeros((d, d))  # scatter matrix for each class
        for row in X[target == label]:
            row, mc = row.reshape(d, 1), mc.reshape(d, 1)  # make column vectors
            class_scatter += (row - mc).dot((row - mc).T)
        S_W += class_scatter  # sum class scatter matrices

    mean_total = np.mean(X, axis=0)
    S_B = np.zeros((d, d))
    for label, mc in zip(['Iris-setosa', 'Iris-versicolor', 'Iris-virginica'], mean_class):
        n = X[iris_target == label, :].shape[0]
        mc = mc.reshape(d, 1)  # make column vector
        mean_total = mean_total.reshape(d, 1)  # make column vector
        S_B += n * (mc - mean_total).dot((mc - mean_total).T)

    eigVals_LDA, eigVecs_LDA = np.linalg.eig(np.linalg.inv(S_W).dot(S_B))
    eig_pairs_LDA = [(np.abs(eigVals_LDA[i]), eigVecs_LDA[:, i]) for i in range(n_features)]
    # sort eig_vec based on eig_val from highest to lowest
    eig_pairs_LDA.sort(reverse=True)
    # Compute r eigenvectors with largest eigenvalues
    C_LDA = np.array([ele[1] for ele in eig_pairs_LDA[:n]])
    # get new data
    Y_LDA= np.dot(X, np.transpose(C_LDA))
    return  Y_LDA

Y = PCA(iris_data,2)
Y_LDA = LDA(iris_data,iris_target,2)

plt.figure(figsize=(16,9))
plt.subplot(1, 2, 1)
for color,target_name in zip("rgb", ['Iris-setosa','Iris-versicolor','Iris-virginica']):
    plt.scatter(np.array(Y[iris_target == target_name, 0]), np.array(Y[iris_target == target_name, 1]), c=color,label=target_name)
plt.xlabel('Dimension1')
plt.ylabel('Dimension2')
plt.title("Iris_PCA")
plt.legend()

plt.subplot(1, 2, 2)
for color,target_name in zip("rgb", ['Iris-setosa','Iris-versicolor','Iris-virginica']):
    plt.scatter(np.array(Y_LDA[iris_target == target_name, 0]), np.array(Y_LDA[iris_target == target_name, 1]), c=color,label=target_name)
plt.xlabel('Dimension1')
plt.ylabel('Dimension2')
plt.title("Iris_LDA")
plt.legend()
plt.savefig("PCA and LDA.png")
plt.show()


def PCA1(data, n):
    from sklearn.decomposition import PCA
    pca = PCA(n_components=n)
    pca_result = pca.fit_transform(data)
    return pca_result


def LDA1(data, target, n):
    from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
    lda = LDA(n_components=n)
    lda_result = lda.fit_transform(data, target)
    return lda_result


def plot(data, target, n):
    pca_result = PCA1(data, n)
    lda_result = LDA1(data, target, n)

    plt.figure(figsize=(16, 9))
    plt.subplot(1, 2, 1)
    for color, target_name in zip("rgb", ['Iris-setosa', 'Iris-versicolor', 'Iris-virginica']):
        plt.scatter(np.array(pca_result[iris_target == target_name, 0]),
                    np.array(pca_result[iris_target == target_name, 1]), c=color, label=target_name)
    plt.title('PCA(sklearn) on iris')

    plt.subplot(1, 2, 2)
    for color, target_name in zip("rgb", ['Iris-setosa', 'Iris-versicolor', 'Iris-virginica']):
        plt.scatter(np.array(lda_result[iris_target == target_name, 0]),
                    np.array(lda_result[iris_target == target_name, 1]), c=color, label=target_name)
    plt.title('LDA(sklearn) on iris')
    plt.savefig("PCA(sklearn) and LDA(sklearn).png")
    plt.show()


plot(iris_data, iris_target, 2)