function SyS_P5_Starset5(N,N1)
n=linspace(-N1,N1,N1+N1+1);

xf=zeros([1,4*N+1]);

for i=-3:3
    for j=-N1:N1
       pos=N*i+j+2*N+1;
       if pos>0 & pos<=4*N+1
            xf(pos)=1;
       end
    end
end

k=linspace(-2*N,2*N,4*N+1);

ak=zeros([1,4*N+1]);

for i=1:4*N+1
    if(mod(k(i),N)==0)
        ak(i)=(2*N1+1)/N;
    else
        ak(i)=((1/N)*(sin(2*pi*k(i)*(N1+1/2)/N))/sin((pi*k(i))/N));
    end
end

subplot(2,1,1)
stem(k,xf)
ylim([-.5 1.5])
title('Tren de impulsos')

subplot(2,1,2)
stem(k,ak)
title('Coeficientes de Fourier')

