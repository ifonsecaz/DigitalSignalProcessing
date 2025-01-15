%Starset
%Israel Fonseca
%Luis Hernandez
%Práctica 10

function SyS_P10_Starset(A1,A2,Wp,Ws)

[n0,Wn0]=buttord(Wp,Ws,A1,A2,'s');

[n1,Wn1]=cheb1ord(Wp,Ws,A1,A2,'s');

[n2,Wn2]=ellipord(Wp,Ws,A1,A2,'s');

%[n0 Wn0, n1 Wn1, n2 Wn2]

[z,p,k]=buttap(n0);

[z1,p1,k1]=cheb1ap(n0,A1);

[z2,p2,k2]=ellipap(n0,A1,A2);


[b,a]=zp2tf(z,p,k);
l=0:1/100:2.5;
[h,w]=freqs(b,a,l);

[b1,a1]=zp2tf(z1,p1,k1);
[h1,w1]=freqs(b1,a1,l);

[b2,a2]=zp2tf(z2,p2,k2);
[h2,w2]=freqs(b2,a2,l);

plot(w,abs(h));
hold on
plot(w1,abs(h1));
hold on
plot(w2,abs(h2));
legend('Butterworth','Chebyshev','Elíptico');
xlabel('Frecuencia Lineal');
ylabel('Amplitud');

%[x,y] = cheby1(n1,A1,Wp);
%freqz(x,y,512,1000) 
%figure
%freqz(b,a)
%figure
%freqz(b1,a1)
%figure
%freqz(b2,a2)