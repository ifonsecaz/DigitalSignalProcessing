function SyS_P5_Starset4(N,N1)

n=linspace(-N*2,N*2,4*N+1);
x=zeros([1,4*N+1]);

for i=-3:3
    for j=-N1:N1
       pos=N*i+j+2*N+1;
       if pos>0 & pos<=4*N+1
            x(pos)=1;
       end
    end
end

stem(n,x)
ylim([-.5,1.5])