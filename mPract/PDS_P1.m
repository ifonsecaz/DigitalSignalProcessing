    function PDS_P1
%Telescope
%Israel Fonseca Zárate

%Creamos un vector con suficientes puntos para parecer una señal continua
t=linspace(0,1,1000);
f=5; %Frecuencia

x=cos(2*pi*f*t);

%Gráfica de la señal continua
subplot(2,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Señal continua')

%Vector para una señal discreta
n=linspace(0,1,81); %16 muestras por 5 ciclos
xs=cos(2*pi*f*n);

%Gráfica
subplot(2,1,2)
plot(t,x)
hold on
stem(n,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('16 muestras por ciclo')

figure
%A continuación se prueba la misma señal, con diferente número de muestras
n1=linspace(0,1,41); 
xs=cos(2*pi*f*n1);

subplot(2,2,1)
plot(t,x)
hold on
stem(n1,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('8 muestras por ciclo')

n2=linspace(0,1,21); 
xs=cos(2*pi*f*n2);

subplot(2,2,2)
plot(t,x)
hold on
stem(n2,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('4 muestras por ciclo')

n3=linspace(0,1,11); 
xs=cos(2*pi*f*n3);

subplot(2,2,3)
plot(t,x)
hold on
stem(n3,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('2 muestras por ciclo')

n4=linspace(0,1,6); 
xs=cos(2*pi*f*n4);

subplot(2,2,4)
plot(t,x)
hold on
stem(n4,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('1 muestras por ciclo')

figure

%Cuantización
%Señal original
subplot(4,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Señal continua')

%32 muestras por ciclo
n5=linspace(0,1,161);
xs=cos(2*pi*f*n5);

%Redondeo con 1 decimal
subplot(4,1,2)
stem(n5,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('32 muestras por ciclo')

xsC=round(xs,1);

subplot(4,1,3)
stem(n5,xsC)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Señal cuantificada')

xsR=xs-xsC;

subplot(4,1,4)
stem(n5,xsR)
grid on
ylim([-0.05,0.05])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Error de cuantización')

figure

subplot(4,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Señal continua')

subplot(4,1,2)
stem(n5,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('32 muestras por ciclo')

%Cuantificación con la señal piso
xsC=floor(xs);

subplot(4,1,3)
stem(n5,xsC)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Señal cuantificada con función piso')

xsR=xs-xsC;

subplot(4,1,4)
stem(n5,xsR)
grid on
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Error de cuantización')

figure

subplot(4,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Señal continua')

subplot(4,1,2)
stem(n5,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('32 muestras por ciclo')

%Cuantificación con la señal techo
xsC=ceil(xs);

subplot(4,1,3)
stem(n5,xsC)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Señal cuantificada con función techo')

xsR=xs-xsC;

subplot(4,1,4)
stem(n5,xsR)
grid on
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Error de cuantización')