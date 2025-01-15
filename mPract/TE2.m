e0=8.85*10^-12;
m=4*pi*10^-7;
n=linspace(1,80,80);

e=e0*n;

for i=1:80
    
    c(i)=1/((e(i)*m)^(1/2));

end

plot(n,c);
title('Influencia del medio sobre la velocidad de onda')
xlabel('Indice de refracci�n n')
ylabel('Velocidad m/s')

c=3*10^8;

nr=c*(m*e).^(1/2);

figure 
plot(n,nr);

figure
for j=1:80
    nr(j)=c*(m*e(j))^(1/2);
    
end
plot(n,nr)
title('Influencia del medio sobre el �ndice de refracci�n')
ylabel('�ndice de refracci�n')
xlabel('Medio n')



