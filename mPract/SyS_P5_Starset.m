function SyS_P5_Starset(N,N1)
n1=[-N1:N1];
N0=[-2*N:2*N];

x=ones(1,length(n1));
%concatenación 1 periodo
x=[zeros([1,((N-N1)*2)/2]),x,zeros([1,((N-N1)*2)/2])];
%Concatenación de 4 periodos
x1=[x,x,x,x];

length(x1)

n2=linspace(-(N*2),(N*3),(N*5)+1);

length(n2)

k=-2*N1;
i=1;

a=zeros(1,length(N0));

while k<=2*N1
    if k==0
        a(1,i)=((2*N)+1)/N;
    else
        a(1,i)=(1/N)*(sin(2*pi*k*(N1+1/2)/N)/sin((pi*k)/N));
    end
    k=k+1;
    i=i+1;
end

subplot(2,1,1)
stem(n2,x1(1:51))

subplot(2,1,2)
stem(N0,a)

