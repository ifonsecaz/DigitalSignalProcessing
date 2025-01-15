%Calcular función de transferencia polos y ceros
n=[0.2 0.8]; %numerador
d=[0.09 -0.01 -0.9]; %denominador

sys=tf(n,d)
[z,p,k]=tf2zp(n,d)

%1-1.3z^-1+0.91z^-2-.18z^-3
%p=[1 -1.3 0.91 -0.18];
%r=roots(p)
%Cambiar signos al pasar (z-12.9+2i)