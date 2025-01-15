function SyS_Practica2_2

t=linspace(0,30,31);

subplot(3,3,1);
y=cos(t);
stem(t,y);
title("x[n]=cos(n)");

subplot(3,3,2);
y=cos(pi*t/8);
stem(t,y);
title("x[n]=cos(pi*n/8)");

subplot(3,3,3);
y=cos(pi*t/4);
stem(t,y);
title("x[n]=cos(pi*n/4)");

subplot(3,3,4);
y=cos(pi*t/2);
stem(t,y);
title("x[n]=cos(pi*n/2)");

subplot(3,3,5);
y=cos(pi*t);
stem(t,y);
title("x[n]=cos(pi*n)");

subplot(3,3,6);
y=cos(3*pi*t/2);
stem(t,y);
title("x[n]=cos(3*pi*n/2)");

subplot(3,3,7);
y=cos(7*pi*t/4);
stem(t,y);
title("x[n]=cos(7*pi*n/4)");

subplot(3,3,8);
y=cos(15*pi*t/8);
stem(t,y);
title("x[n]=cos(15*pi*n/8)");

subplot(3,3,9);
y=cos(2*pi*t);
stem(t,y);
title("x[n]=cos(2*pi*n)");

