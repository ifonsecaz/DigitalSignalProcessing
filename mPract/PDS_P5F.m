%Telescope
%Detección de notas

%Lectura del audio
[y, fs]=audioread('theme1.wav');
t=(0:1:length(y)-1)/fs;

fprintf('Duración = %f segundos\n',max(t))
fprintf('Frecuencia de muestreo = %f\n',fs)

plot(t,y)
grid on
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Theme Dominio del tiempo')
%sound(y,fs)
figure

%Se obtiene el espectrograma
spectrogram(y,256,0,2048,fs,'yaxis');
[s,w,t]=spectrogram(y,256,0,2048,fs,'yaxis');

figure
[f0,loc]=pitch(y,fs); %Función pitch estima la frecuencia fundamental
plot(f0)

%Generación de las notas, de A0 a C8
r=2^(1/12);
notas=zeros(1,88);
k=2; %Cominenzo a agregarlas al vector desde la segunda posición, la primera corresponde a un silencio
notas(1)=0;
for i=-48:39
    notas(k)=440*(r^(i));
    k=k+1;
end

X=zeros(1,16); %Vector auxiliar para guardar las frecuencias fundamentales

%Eliminar silencio inicial
f=s(:,1);
inicio=1;
while(abs(max(f))<0.8) %Se considera que inicia la canción, cuando la máxima energía supera 0.8
   inicio=inicio+1;
   f=s(:,inicio);
end

%numN=linspace(inicio,length(t),50); %Para el tema 2 tiene 49 notas, consideramos que tienen un espaciado igual
%numN=numN(2:length(numN)); %Quito el primer punto

numN=[79,139,197,321,444,565,686,808,929,990,1051,1112,1233,1354,1476,1618]; %Para el tema 1 tiene 16 notas

k=1; %Indice para indicar la posición para agregar la nueva nota
Indice=1; %Guarda el índice para hallar la frecuencia correspondiente a la máxima energía
maxA=0; %Va guardanda la máxima energía por ventana

maxEnergia=max(abs(s));
minF=4000;
maxF=0;

for j=inicio:length(t) %El ciclo va a partir de que se considera que inició la canción hasta el final de la señal
    f=s(:,j); %Extraemos una ventana del espectrograma
    [M,I]=max(abs(f)); %Se obtiene la energía y el índice de la máxima energía en la ventana
    
    if(maxA<=M&&w(I)~=0) %Compara con la energía anterior y se asegura que no corresponda a una frecuencia de 0
        maxA=M;
        Indice=j;
    end
    
    if M>.707*maxEnergia
       if w(I)>maxF
           maxF=w(I);
       end
       if w(I)<minF
           minF=w(I);
       end
    end
    
    if(j>=numN(k))
        fFund=knnsearch(loc,(Indice+inicio)*256);
        X(1,k)=f0(fFund); %Agrega al vector con las frecuencias de las notas, la frecuencia con la mayor energía encontrada
        k=k+1;
        maxA=0;
        Indice =0;
    end
end
Ancho=(minF+"-"+maxF);
fprintf('Ancho de banda = %s Hz\n',Ancho)
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