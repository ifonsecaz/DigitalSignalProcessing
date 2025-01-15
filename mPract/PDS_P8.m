i=imread('livingroom.tif');
imshow(i)
%figure
%I=mat2gray(log(abs(fftshift(fft2(i)))+1));
%imshow(I);

a=[0 -1 0;-1 5 -1;0 -1 0];

b=[-1 -2 -1;-2 13 -2;-1 -2 -1];

c=[1 -2 1;-2 5 -2;1 -2 1];

d=[0.0625 0.125 0.0625;0.125 0.25 0.125;0.0625 0.125 0.0625];

%salida=conv2(i,a);
salida=imfilter(i,a);
figure
%imshow(mat2gray(salida));
imshow(salida);

%salida=conv2(i,b);
salida=imfilter(i,b);
figure
%imshow(mat2gray(salida));
imshow(salida);

%salida=conv2(i,c);
salida=imfilter(i,c);
figure
%imshow(mat2gray(salida));
imshow(salida);

%salida=conv2(i,d);
salida=imfilter(i,d);
figure
%imshow(mat2gray(salida));
imshow(salida);


i=imread('lena_gray_512.tif');
figure
imshow(i)


h=fspecial('gaussian',[5 5],0.1);
salida=imfilter(i,h);
figure
imshow(salida);

h=fspecial('gaussian',[5 5],1);
salida=imfilter(i,h);
figure
imshow(salida);

h=fspecial('gaussian',[5 5],10);
salida=imfilter(i,h);
figure
imshow(salida);

h=fspecial('prewitt');
salida=imfilter(i,h);
figure
imshow(salida);

h=fspecial('sobel');
salida=imfilter(i,h);
figure
imshow(salida);

roberts1=[-1 0;0 1];
salida=imfilter(i,roberts1);
figure
imshow(salida);

roberts2=[0 1;-1 0];
salida=imfilter(i,roberts2);
figure
imshow(salida);



