function SyS_P5_Starset6(M)
k=linspace(-20,20,41);
x=linspace(-9,9,19);
ak=zeros(1,19);
N=9;
N1=2;

for i=1:N+N+1
    for j=-M:M
        aux=((1/N)*(sin(2*pi*j*(N1+1/2)/N))/sin((pi*j)/N));
        %aux2=exp(j*(2*pi/N)*x(i));
        aux2=1;
        ak(i)=ak(i)+aux*aux2;
    end
end

r=[ak(2:18),ak,ak(2:18)];
rf=r(7:47);

stem(k,rf)
ylim([-.5 1.5])