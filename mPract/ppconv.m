
t1=linspace(0,900,40000);
t2=linspace(900,1100,4000);
t3=linspace(1100,1300,40000);
t4=linspace(1300,2600,40000);

x0=0*t1;
x1=t2-900;
x2=1300-t3;
x3=0*t4;

tr=[x0 x1 x2 x3];
t=[t1 t2 t3 t4];
plot(t,tr)

tr2=tr;

w=conv(tr,tr2);
figure
tn=linspace(0,2600,247999);

plot(tn,w)