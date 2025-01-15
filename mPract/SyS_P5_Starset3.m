function SyS_P5_Starset3(M)
k=linspace(-20,20,41); %k=-20:1:20
x=linspace(-9,9,19);
ak=zeros(1,19);
N=9;
N1=2;

for i=1:N+N+1
    for j=1:M
        aux=((1/N)*(sin(2*pi*j*(N1+1/2)/N))/sin((pi*j)/N));
        aux2=2*cos(j*2*pi*x(i)/N);
        ak(i)=ak(i)+aux*aux2;
    end
    ak(i)=ak(i)+(2*N1+1)/N;
end

r=[ak(2:18),ak,ak(2:18)];
rf=r(7:47);

stem(k,rf)
ylim([-.5 1.5])

    