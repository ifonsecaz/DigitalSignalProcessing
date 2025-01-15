function SyS_P5_Starset2(N,N1)
n=linspace(-N1,N1,N1+N1+1);

%x=ones([1,N1+N1+1]);
%x1=zeros([1,N-2*N1-1]);
%x2=x(1:ceil(length(n)/2));
%xf=[x2,x1,x,x1,x2];

xf=zeros([1,2*N+1]);
for i=-2:2
    for j=-N1:N1
       pos=N*i+j+N+1;
       if pos>0 & pos<=2*N+1
            xf(pos)=1;
       end
    end
end


k=linspace(-N,N,N+N+1);

ak=zeros([1,N+N+1]);

for i=1:N+N+1
    if(k(i)==0)
        ak(i)=(2*N1+1)/N;
    else
        ak(i)=((1/N)*(sin(2*pi*k(i)*(N1+1/2)/N))/sin((pi*k(i))/N));
    end
end


subplot(2,1,1)
stem(k,xf)
ylim([-.5 1.5])

subplot(2,1,2)
stem(k,ak)


