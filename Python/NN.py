import numpy as np

def activare(x, deriv=False):
    if deriv == True:
        return x*(1-x)
    return 1/(1+np.exp(-x))

x = np.array([[1, 0, 0, 1],[1, 0, 1, 1], [1, 1, 0, 10], [1, 1, 1, 1]])
y = np.array([[0, 0, 1, 1]]).T
np.random.seed(1)
w0 = np.random.random((4, 1))*2-1
for i in range(10000):
    l0 = x
    l1 = activare(np.dot(l0, w0)) #out y
    l1_err = y-l1
    l1_delta = 0.1*l1_err*activare(l1, True) #dEr_tot/dg(y)*g(y)*(1-g(y))
    w0 += np.dot(l0.T, l1_delta)

print("After training we get: ")
print(l1)
