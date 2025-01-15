function SyS_Practica3
%Starset
%Israel Fonseca Zárate

%Actividad 1
%Se generan dos funciones:
%x[n]=2?[n-1]+4?[n-2]-1?[n-3]
%h[n]=u[n]-u[n-4]
x=[0,2,4,-1];
h=[1,1,1,1];
n=[0,1,2,3];

%Gráfica de ambas funciones con valores para n del 0 al 3
subplot(2,2,1)
stem(n,x)
xlim([-1,4])
ylim([-2,5])
title('x[n]')

subplot(2,2,2)
stem(n,h)
xlim([-1,4])
ylim([-2,5])
title('h[n]')

%Se aplica la función convolución, que toma dos señales de entrada y las
%transforma en una señal de salida, se expresa como x[n]*h[n]
y=conv(x,h);
n=[0:6];

subplot(2,2,[3,4])
stem(n,y)
xlim([-2,8])
ylim([-2,7])
title('x[n]*h[n]')

%Actividad 2
%Se generan dos nuevas funciones
%x[n]=cos(pi/10*n)
%h[n]= señal con valores aleatorios entre 0 y 1
n1=linspace(0,20,21);
n2=linspace(0,10,11);

x=cos(pi*n1/10);
h=rand([1,11]);

figure
subplot(2,2,1)
stem(n1,x)
xlim([-1,21])
ylim([-2,2])
title('x[n]')

subplot(2,2,2)
stem(n2,h);
xlim([-1,11])
ylim([-2,2])
title('h[n]')

%Se comprueba que la convolución es conmutativa, es decir 
%x[n]*h[n]=h[n]*x[n]
y1=conv(x,h);
y2=conv(h,x);

n3=[0:30];

subplot(2,2,3)
stem(n3,y1)
xlim([-1,30])
ylim([-5,5])
title('x[n]*h[n]')

subplot(2,2,4)
stem(n3,y2)
xlim([-1,30])
ylim([-5,5])
title('h[n]*x[n]')

%Actividad 3
%Se retoma las dos funciones anteriores, x[n] y h[n]
%y se genera una tercera función h2[n] con valores aleatorios pero de -1 a 0
figure

h2=rand([1,11])*(-1);

subplot(4,3,1)
stem(n1,x)
xlim([-1,21])
ylim([-2,2])
title('x[n]')

subplot(4,3,2)
stem(n2,h)
xlim([-1,11])
ylim([-2,2])
title('h1[n]')

subplot(4,3,3)
stem(n2,h2)
xlim([-1,11])
ylim([-2,2])
title('h2[n]')

%Se busca probar la propiedad distributiva de la convolución, es decir:
%x[n]*(h[n]+h2[n])=(x[n]*h[n])+(x[n]*h2[n])

%Para la primera parte se aplica primero la suma de h y h2, el resultado se
%convoluciona con x y genera y1
%Para la segunda parte se convoluciona x*h2 y x*h, lo que genera c1 y c2,
%los cuales se suman y dan y2
h3=h+h2;

subplot(4,3,4)
stem(n2,h3)
xlim([-1,11])
ylim([-2,2])
title('h1[n]+h2[n]')

c1=conv(x,h);

subplot(4,3,5)
stem(n3,c1)
xlim([-1,31])
ylim([-5,5])
title('x[n]*h1[n]')

c2=conv(x,h2);

subplot(4,3,6)
stem(n3,c2)
xlim([-1,31])
ylim([-5,5])
title('x[n]*h2[n]')

y1=conv(x,h3);

subplot(4,3,[7:9])
stem(n3,y1)
xlim([-1,31])
ylim([-2,2])
title('x[n]*(h1[n]+h2[n])')

y2=c1+c2;

subplot(4,3,[10:12])
stem(n3,y2)
xlim([-1,31])
ylim([-2,2])
title('(x[n]*h1[n])+(x[n]*h2[n])')

%Actividad 4
%Retomando las 3 funciones del inciso anterior: x[n], h[n], h2[n]
%Se comprueba la propiedad asociativa de la convolución, es decir,
%x[n]*(h[n]*h2[n])=(x[n]*h[n])*h2[n]
figure

subplot(3,4,1)
stem(n1,x)
xlim([-1,21])
ylim([-2,2])
title('x[n]')

subplot(3,4,2)
stem(n2,h)
xlim([-1,11])
ylim([-2,2])
title('h1[n]')

subplot(3,4,3)
stem(n2,h2)
xlim([-1,11])
ylim([-2,2])
title('h2[n]')

%Para la primera parte del igual, se convoluciona x con h, lo que da c1, y
%el resultado se convoluciona con h2 y genera y1
%Para la segunda parte, se convoluciona h y h2 que da c2, y este se
%convoluciona con x, el resultado se llama y2
c1=conv(x,h);

c2=conv(h,h2);

subplot(3,4,[5 6])
stem(n3,c1)
xlim([-1,31])
ylim([-5,5])
title('x[n]*h1[n]')

subplot(3,4,[7 8])
stem(n1,c2)
xlim([-1,21])
ylim([-5,5])
title('h1[n]*h2[n]')

y1=conv(c1,h2);

y2=conv(c2,x);

n4=[0:40];

subplot(3,4,[9 10])
stem(n4,y1)
xlim([-1,41])
ylim([-15,15])
title('(x[n]*h1[n])*h2[n]')

subplot(3,4,[11 12])
stem(n4,y2)
xlim([-1,41])
ylim([-15,15])
title('x[n]*(h1[n]*h2[n])')

