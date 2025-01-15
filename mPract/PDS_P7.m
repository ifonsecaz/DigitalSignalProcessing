s=-250:250; %Generamos un vector con 501 valores
y=sin(2*pi*(2/501)*s); 
i=repmat(y, [501,1]); %Se repite el vector en 501 renglones
imshow(i); %Gráfica
title('Señal Senoidal en 2D')

figure
I=fft2(i);
imshow(abs(fftshift(I)));
title('2D FFT')

figure
s=-250:250; %Generamos un vector con 501 valores
y1=sin(2*pi*(2/501)*s);
y2=cos(2*pi*(2/501)*s); 
y=[y1;y2];
i=repmat(y, [255,1]); %Se repite el vector en 501 renglones
imshow(i); %Gráfica
title('Señal Senoidal en 2D')

figure
I=fft2(i);
imshow(abs(fftshift(I)));
title('2D FFT')

figure
s=-250:250; %Generamos un vector con 501 valores
for i=1:5
    y=y+sin(i*2*pi*(2/501)*s);
end
i=repmat(y, [501,1]); %Se repite el vector en 501 renglones
imshow(i); %Gráfica
title('Señal Senoidal en 2D')

figure
I=fft2(i);
imshow(abs(fftshift(I)));
title('2D FFT')

figure
i=imread('C:\Users\ifons\Documents\MatLab\toolbox\images\imdata\cameraman.tif');
%i=imread('p.jpg');
imshow(i)
figure
I=mat2gray(log(abs(fftshift(fft2(i)))+1));
imshow(I);

H = fspecial('disk',3);
filtered = imfilter(i,H); 
figure
imshow(filtered);
%{
figure
I=mat2gray(log(abs(fftshift(fft2(filtered)))+1));
imshow(abs(fftshift(I)));
title('2D FFT')
%}
