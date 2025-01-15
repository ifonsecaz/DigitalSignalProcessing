function SyS_P6_Starset(n,d)
%Starset
%Israel Fonseca Z�rate
%Luis Hern�ndez

%Funci�n de transferencia
sys=tf(n,d)

%Calculo de los polos y ceros de la funci�n
[z,p,k]=tf2zp(n,d)

subplot(3,1,1)
%Mapea los polos y ceros
pzmap(sys)

subplot(3,1,2)
%Grafica la respuesta al impulso
impulse(sys)

subplot(3,1,3)
%Grafica la respuesa al escal�n
step(sys)