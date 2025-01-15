    function PDS_P1
%Telescope
%Israel Fonseca Z�rate

%Creamos un vector con suficientes puntos para parecer una se�al continua
t=linspace(0,1,1000);
f=5; %Frecuencia

x=cos(2*pi*f*t);

%Gr�fica de la se�al continua
subplot(2,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Se�al continua')

%Vector para una se�al discreta
n=linspace(0,1,81); %16 muestras por 5 ciclos
xs=cos(2*pi*f*n);

%Gr�fica
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
%A continuaci�n se prueba la misma se�al, con diferente n�mero de muestras
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

%Cuantizaci�n
%Se�al original
subplot(4,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Se�al continua')

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
title('Se�al cuantificada')

xsR=xs-xsC;

subplot(4,1,4)
stem(n5,xsR)
grid on
ylim([-0.05,0.05])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Error de cuantizaci�n')

figure

subplot(4,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Se�al continua')

subplot(4,1,2)
stem(n5,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('32 muestras por ciclo')

%Cuantificaci�n con la se�al piso
xsC=floor(xs);

subplot(4,1,3)
stem(n5,xsC)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Se�al cuantificada con funci�n piso')

xsR=xs-xsC;

subplot(4,1,4)
stem(n5,xsR)
grid on
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Error de cuantizaci�n')

figure

subplot(4,1,1)
plot(t,x)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Se�al continua')

subplot(4,1,2)
stem(n5,xs)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('32 muestras por ciclo')

%Cuantificaci�n con la se�al techo
xsC=ceil(xs);

subplot(4,1,3)
stem(n5,xsC)
grid on
ylim([-1,1])
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Se�al cuantificada con funci�n techo')

xsR=xs-xsC;

subplot(4,1,4)
stem(n5,xsR)
grid on
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Error de cuantizaci�n')