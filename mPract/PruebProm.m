%Telescope
%Detecci�n de notas

%Lectura del audio
[y, fs]=audioread('theme1.wav');
t=(0:1:length(y)-1)/fs;

fprintf('Duraci�n = %f segundos\n',max(t))
fprintf('Frecuencia de muestreo = %f\n',fs)

plot(y);
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Theme Dominio del tiempo')

yAux=movmean(abs(y),256);

%sound(y,fs)
figure

[pks,locs,~,prm] = findpeaks(yAux,'MinPeakDistance',12000);
[B,i] = sort(prm,'descend');
plot(1:numel(yAux),yAux,'-',locs(i(1:16)),yAux(locs(i(1:16))),'o ')
%%Grafica los picos de Theme1

%Grafica los picos de Theme2
%plot(1:numel(yAux),yAux,'-',locs(i(1:49)),yAux(locs(i(1:49))),'o ')

picos=i(1:16); %Usar para Theme1
%picos=i(1:49); %Usar para Theme2
picos=sort(picos,'ascend');

[f0,loc]=pitch(y,fs); %Funci�n pitch estima la frecuencia fundamental
plot(f0)

%Generaci�n de las notas, de A0 a C8
r=2^(1/12);
notas=zeros(1,88);
k=2; %Cominenzo a agregarlas al vector desde la segunda posici�n, la primera corresponde a un silencio
notas(1)=0;
for i=-48:39
    notas(k)=440*(r^(i));
    k=k+1;
end

figure
%Se obtiene el espectrograma
spectrogram(y,256,0,2048,fs,'yaxis');
[s,w,t]=spectrogram(y,256,0,2048,fs,'yaxis');

X=zeros(1,16);
numN=zeros(1,16);

for i=1:length(picos)
   numN(i)=picos(i);
end
if(numN(1)==0)
    Inicio=1;
else
    Inicio=numN(1);
end
numN=numN(2:length(numN));
numN(length(numN)+1)=length(t);

k=1; %Indice para indicar la posici�n para agregar la nueva nota
Indice=1; %Guarda el �ndice para hallar la frecuencia correspondiente a la m�xima energ�a
maxA=0; %Va guardanda la m�xima energ�a por ventana

maxEnergia=max(abs(s));
minF=4000;
maxF=0;

vt=Inicio;
for i=1:length(numN)
    [f0,loc]=pitch(y(vt:numN(i)));
    
    X(1,i)=mean(f0);
    
    vt=numN(i)+1;
end

for j=Inicio:length(t) %El ciclo va a partir de que se considera que inici� la canci�n hasta el final de la se�al
    f=s(:,j); %Extraemos una ventana del espectrograma
    [M,I]=max(abs(f)); %Se obtiene la energ�a y el �ndice de la m�xima energ�a en la ventana
   
    
    if M>.707*maxEnergia
       if w(I)>maxF
           maxF=w(I);
       end
       if w(I)<minF
           minF=w(I);
       end
    end
end
Ancho=(minF+"-"+maxF);
fprintf('Ancho de banda = %s Hz\n',Ancho)
%Imprime las frecuencias fundamentales
X

nota=knnsearch(transpose(notas),transpose(X)); %Para cada frecuencia fundamental extra�da, ubica la frecuencia de la nota de piano m�s cercana

NotaF=["Silencio" "A0" "A0#" "B0" "C1" "C1#" "D1" "D1#" "E1" "F1" "F1#" "G1" "G1#" "A1" "A1#" "B1" "C2" "C2#" "D2" "D2#" "E2" "F2" "F2#" "G2" "G2#" "A2" "A2#" "B2" "C3" "C3#" "D3" "D3#" "E3" "F3" "F3#" "G3" "G3#" "A3" "A3#" "B3" "C4" "C4#" "D4" "D4#" "E4" "F4" "F4#" "G4" "G4#" "A4" "A4#" "B4" "C5" "C5#" "D5" "D5#" "E5" "F5" "F5#" "G5"  "G5#" "A5" "A5#" "B5" "C6" "C6#" "D6" "D6#" "E6" "F6" "F6#" "G6" "G6#" "A6" "A6#" "B6" "C7" "C7#" "D7" "D7#" "E7" "F7" "F7#" "G7" "G7#" "A7" "A7#" "B7" "C8"];
melodia=strings([1,16]); 

nota=transpose(nota);
n=1;
while n<=length(nota) %Asigno el nombre de la nota a las frecuencias
    melodia(n)=NotaF(nota(n));
    n=n+1;
end
melodia