
d=[0.1995         0    1.0916         0    2.0902         0    1.7039         0    0.5057];
n=[1.0000    0.6289    3.6510    1.8608    4.9386    1.8349    2.9242    0.6030    0.6366];
sys=tf(d,n)

[z,p,k]=tf2zp(d,n)