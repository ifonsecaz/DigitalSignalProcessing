function pp

%t=linspace(0,200,40000);
t1=linspace(0,200,40000);
t2=linspace(200,400,40000);
t3=linspace(400,600,40000);
t4=linspace(600,800,40000);
%x=0*t;
x1=-(t1.^3)/6+200*t1.^2;
x2=(t2.^3)/2-600*(t2.^2)+240000*t2-21333333;
x3=-(t3.^3)/2+600*(t3.^2)-240000*t3+42666666;
x4=(t4.^3)/6-200*t4.^2+(128000000/3);
subplot(2,2,1)
plot(t4,x4)
subplot(2,2,2)
plot(t1,x1)
subplot(2,2,3)
plot(t2,x2)
subplot(2,2,4)
plot(t3,x3)

figure
r=[x1 x2 x3 x4];
n=[t1 t2 t3 t4];
plot(n,r)
