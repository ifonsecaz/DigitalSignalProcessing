function SyS_Practica2
%Starset
%Israel Fonseca

%Actividad 1
%Generar una función con exponencial y la función trigonométrica: seno
%Se crea un vector de tiempo del 1 al 100, dividido en 100000 puntos, para
%obtener una función de apariencia continua
t=linspace(1,100,100000);
%Funión a graficar, para cada punto del vector tiempo se calcula su
%correspondiente y
y=exp(.3*t).*sin(2*pi*t);
%Comando para graficar, con label se insertan etiquetas para los ejes de la
%gráfica
plot(t,y);
xlabel("Tiempo [s]");
ylabel("Amplitud")
title("Función exponencial compleja")

%Actividad 2
%Gráficas de señales discretas
%Se crea nuevamente un vector de tiempo, con menos puntos para que se pueda
%graficar correctamente

%Se utiliza figure, para mantener abierta la gráfica anterior
figure
t=linspace(0,30,31);

%Con subplot, permite insertar varias gráficas en una sola figura
subplot(3,3,1);
y=cos(t);
%Stem grfica la secuencia de datos de forma discreta
stem(t,y);
title("x[n]=cos(n)");
%Se usa lim para ajustar los ejes de la gráfica, en lugar de que los decida
%automaticamente Matlab
ylim([-1.5 1.5]);

subplot(3,3,2);
y=cos(pi*t/8);
stem(t,y);
title("x[n]=cos(pi*n/8)");
ylim([-1.5 1.5]);

subplot(3,3,3);
y=cos(pi*t/4);
stem(t,y);
title("x[n]=cos(pi*n/4)");
ylim([-1.5 1.5]);

subplot(3,3,4);
y=cos(pi*t/2);
stem(t,y);
title("x[n]=cos(pi*n/2)");
ylim([-1.5 1.5]);

subplot(3,3,5);
y=cos(pi*t);
stem(t,y);
title("x[n]=cos(pi*n)");
ylim([-1.5 1.5]);

subplot(3,3,6);
y=cos(3*pi*t/2);
stem(t,y);
title("x[n]=cos(3*pi*n/2)");
ylim([-1.5 1.5]);

subplot(3,3,7);
y=cos(7*pi*t/4);
stem(t,y);
title("x[n]=cos(7*pi*n/4)");
ylim([-1.5 1.5]);

subplot(3,3,8);
y=cos(15*pi*t/8);
stem(t,y);
title("x[n]=cos(15*pi*n/8)");
ylim([-1.5 1.5]);

subplot(3,3,9);
y=cos(2*pi*t);
stem(t,y);
title("x[n]=cos(2*pi*n)");
ylim([-1.5 1.5]);