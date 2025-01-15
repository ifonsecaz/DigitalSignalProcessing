function SyS_P4
%Starset
%Israel_Fonseca_Zárate_183708

%Actividad 1
%Para graficar señales continuas, primero se crea un vector que corresponde
%al tiempo, con suficientes puntos intermedios para que la señal se vea
%correctamente
%Después se crean las funciones x=cos(t/3) y y=cos(t/4)
%Por último se suman las funciones en f=cos(t/3) + cos(t/4), y se grafican
n=linspace(0,250,25100);

x=cos(n/3);
y=cos(n/4);

f1=x+y;

subplot(3,1,1)
plot(n,x)
ylim([-2,2])
title('cos(t/3)')

subplot(3,1,2)
plot(n,y)
ylim([-2,2])
title('cos(t/4)')

subplot(3,1,3)
plot(n,f1)
ylim([-3,3])
title('cos(t/3)+cos(t/4)')

%Actividad 2
%Se crean 3 señales, correspondientes a las funciones x=2, y=cos(2pi/3*t),
%z=4sin(5pi/3*t)
figure

n=linspace(-15,15,1500);

%Para x=2 se crea un vector de unos y se multiplica por 2
x=ones(length(n))*2;
y=cos(2*pi*n/3);
z=4*sin(5*pi*n/3);

%Se suman las tres señales anteriores, para el periodo fundamental, la
%señal x=2 no influye dado que es continua
f2=2+y+z;

subplot(4,1,1)
plot(n,x)
title('2')
ylim([-5,5])

subplot(4,1,2)
plot(n,y)
ylim([-2,2])
title('cos(2*pi*t/3)')

subplot(4,1,3)
plot(n,z)
ylim([-6,6])
title('4sin(5*pi*t/3)')

subplot(4,1,4)
plot(n,f2)
ylim([-6,8])
title('2+cos(2*pi*t/3)+4sin(5*pi*t/3)')

%Actividad 3
%Una señal se puede descomponer en funciones harmonicas, para este caso, se
%descompone la función cuadrada, cuyos valores corresponden a -1 si
%-T/2<t<0 o 1 si 0<t<T/2

figure

%Funciones de las 4 primeros términos de la serie de Fourier de una señal
%cuadrada
f1=sin(pi*n);
f2=1/3*sin(3*pi*n);
f3=1/5*sin(5*pi*n);
f4=1/7*sin(7*pi*n);

f=(4/pi)*(f1+f2+f3+f4);

%Hold on, permite añadir más gráficas a una figura
hold on
plot(n,f1)
plot(n,f2)
plot(n,f3)
plot(n,f4)
plot(n,f)
xlim([-1.1,1.1])
title('Primeros 4 términos de la serie de Fourier para la señal cuadrada')
legend('Primer armonico','Segundo armonico','Tercer armonico','Cuarto armonico','Suma','Location','southeast')

hold off

%Actividad 4
%Para asemejar la gráfica a una señal cuadrada, es necesario sumar más
%términos, por lo que se hace la suma de las primeras 50 armónicas

figure

f=0;
for k=1:50
    f=f+(1/(2*k-1)*sin((2*k-1)*pi*n));
end

f=8*f/(pi^2);

plot(n,f)
xlim([-1.1,1.1])
title('Primeros 50 armonicos de la serie de Fourier cuadrada')

%Actividad 5
%Se grafica serie de Fourier correspondiente a una señal triangular, cuya
%fórmula es 2t si 0<t<T/4, 2(1-t) si T/4<t<3T/4 o 2t si 3T/4<t<T

figure
n=linspace(-2,2,2000);

f=0;
%Se suman los primeros 50 términos
for k=1:50
    f=f+((-1)^(k-1)*(1/(2*k-1))^2*sin((2*k-1)*pi*n));
end

f=f*8/pi^2;

plot(n,f)
ylim([-1.5,1.5])
title('Primeros 50 armonicos de la serie de Fourier para la señal triangular')

%Actividad 6
%Serie de Fourier correspondiente a la función diente de sierra, cuya
%fórmula es t para -T/2<t<T/2
figure

f=0;
%Nuevamente se suman los primeros 50 términos
for k=1:50
    f=f+((-1)^(k+1)*1/k*sin(k*2*pi*n));
end

f=f*2/pi;

plot(n,f)
ylim([-1.5,1.5])
title('Primeros 50 armonicos de la serie de Fourier para la señal "Diente de sierra"')

  

