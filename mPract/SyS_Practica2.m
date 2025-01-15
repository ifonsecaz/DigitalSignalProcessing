function Sys_Practica2

t=linspace(1,100,100000);
y=exp(.3*t).*sin(2*pi*t);
plot(t,y);
xlabel("Tiempo");
ylabel("Amplitud")
title("Función exponencial compleja")

