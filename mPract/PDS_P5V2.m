%Telescope
%Detección de notas

%Lectura del audio
[y, fs]=audioread('theme2.wav');
t=(0:1:length(y)-1)/fs;

fprintf('Duración = %f segundos\n',max(t))
fprintf('Frecuencia de muestreo = %f\n',fs)
MinV=min(y);
MaxV=max(y);
Ancho=MaxV-MinV;
fprintf('Ancho de banda = %s\n',Ancho)

plot(y);
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Theme Dominio del tiempo')

yAux=movmean(abs(y),256);

%sound(y,fs)
figure

[pks,locs,~,prm] = findpeaks(yAux,'MinPeakDistance',12000);
[B,i] = sort(prm,'descend');
%plot(1:numel(yAux),yAux,'-',locs(i(1:16)),yAux(locs(i(1:16))),'o ')
%%Grafica los picos de Theme1

%Grafica los picos de Theme2
plot(1:numel(yAux),yAux,'-',locs(i(1:49)),yAux(locs(i(1:49))),'o ')

%picos=i(1:16); %Usar para Theme1
picos=i(1:49); %Usar para Theme2
picos=sort(picos,'ascend');

figure
%Se obtiene el espectrograma
spectrogram(y,256,0,2048,fs,'yaxis');
[s,w,t]=spectrogram(y,256,0,2048,fs,'yaxis');

X=zeros(1,16);
numN=zeros(1,16);

for i=1:length(picos)
   numN(i)=round(locs(picos(i))/256);
end


k=1; %Indice para indicar la posición para agregar la nueva nota
Indice=1; %Guarda el índice para hallar la frecuencia correspondiente a la máxima energía
maxA=0; %Va guardanda la máxima energía por ventana

for j=1:length(numN) %El ciclo va a partir de que se considera que inició la canción hasta el final de la señal
    f=s(:,numN(j)); %Extraemos una ventana del espectrograma
    [M,I]=max(abs(f)); %Se obtiene la energía y el índice de la máxima energía en la ventana
    
    if(w(I)~=0)
        X(1,j)=w(I); %Agrega al vector con las frecuencias de las notas, la frecuencia con la mayor energía encontrada
    else
       f=s(:,numN(j)+1);
       [M,I]=max(abs(f));
       X(1,j)=w(I);
    end
end
%Imprime las frecuencias fundamentales
X

nota=knnsearch(transpose(notas),transpose(X)); %Para cada frecuencia fundamental extraída, ubica la frecuencia de la nota de piano más cercana

NotaF=["Silencio" "A0" "A0#" "B0" "C1" "C1#" "D1" "D1#" "E1" "F1" "F1#" "G1" "G1#" "A1" "A1#" "B1" "C2" "C2#" "D2" "D2#" "E2" "F2" "F2#" "G2" "G2#" "A2" "A2#" "B2" "C3" "C3#" "D3" "D3#" "E3" "F3" "F3#" "G3" "G3#" "A3" "A3#" "B3" "C4" "C4#" "D4" "D4#" "E4" "F4" "F4#" "G4" "G4#" "A4" "A4#" "B4" "C5" "C5#" "D5" "D5#" "E5" "F5" "F5#" "G5"  "G5#" "A5" "A5#" "B5" "C6" "C6#" "D6" "D6#" "E6" "F6" "F6#" "G6" "G6#" "A6" "A6#" "B6" "C7" "C7#" "D7" "D7#" "E7" "F7" "F7#" "G7" "G7#" "A7" "A7#" "B7" "C8"];
melodia=strings([1,16]); 

nota=transpose(nota);
n=1;
while n<=length(nota) %Asigno el nombre de la nota a las frecuencias
    melodia(n)=NotaF(nota(n));
    n=n+1;
end
melodia