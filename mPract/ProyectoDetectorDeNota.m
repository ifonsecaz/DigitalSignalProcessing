%Telescope
%Detección de notas

%Lectura del audio
[y, fs]=audioread('MoonlightNight.wav'); 
y=y(:,1); %Tomo el primer canal
t=(0:1:length(y)-1)/fs; %Vector de tiempo

fprintf('Duración = %f segundos\n',max(t)) 
fprintf('Frecuencia de muestreo = %f\n',fs)

%Gráfica de la señal de audio en el dominio del tiempo
plot(y);
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Theme Dominio del tiempo')

%Separación en ventanas
yAux=movmean(abs(y),1024); %Suavizado de la señal

%FindPeaks, detecta los picos de la señal, con una distancia mínima entre
%picos de k muestras
%Para elegir la distancia, inicialmente se probó con 12000 muestras,
%mediante la fórmula fs/f, f de los bpm, se modifica el tamaño de las
%ventanas
%Se eligió 13363.63 como tamaño mínimo de las ventanas, corresponde a 200
%bpm
%[pks,locs,~,prm] = findpeaks(yAux,'MinPeakDistance',12000); %12000 muestras de distancia, tomo 44100 muestras en un segundo 
[pks,locs,~,prm] = findpeaks(yAux,'MinPeakDistance',fs/3.3); %13363.63 para bpm=200, hasta 147000 para bpm=20;
%pks es la energía de los picos, locs el índice, prm la prominencia
[B,i] = sort(prm,'descend'); %Se ordenan los picos según su prominencia
%figure
%plot(1:numel(yAux),yAux,'-',locs(i),yAux(locs(i)),'o ') %gráfica antes de
%filtrarlos por su prominencia

%Filtrado por su prominencia
%Se queda con los picos que tengan al menos el 10% de la prominencia del
%máximo
picos=zeros(1);
contP=1;

%Tomando ventanas de 30 segundos, suponiendo que la energía no cambia mucho
numVent=ceil(length(y)/(fs*30));
ventAnt=1;
posVent=zeros(1);
maxPr=zeros(1);
h=1;
while h<=numVent
    if(length(yAux)>(h*fs*30))
        y2Aux=yAux(ventAnt:(h*fs*30));
    else
        y2Aux=yAux(round(ventAnt):round(length(yAux)));
    end
    ventAnt=h*fs*30;
    [pk,loc,~,pr] = findpeaks(y2Aux,'MinPeakDistance',fs/3.3);
    [B2,i2] = sort(pr,'descend');
    posVent(h)=loc(i2(1));
    maxPr(h)=B2(1);
    h=h+1;
end

for f=1:length(B)
    [val,idx]=min(abs(posVent-locs(i(f))));
    if(B(f)>=.1*maxPr(idx))
        picos(contP)=i(f);
        contP=contP+1;
    end
end

figure
plot(1:numel(yAux),yAux,'-',locs(picos),yAux(locs(picos)),'o ') %Gráfica de los picos elegidos
picos=sort(picos,'ascend'); 

%Filtros paso bajas y altas
%Para eliminar algunas inconsistencias de la señal
%27.5 es la frecuencia mínima del piano
%4186 es la frecuencia máxima del piano
cutOff=(27.5*2)/fs;
b=fir1(2000,cutOff,'high');
y=conv(y,b);

cutOff=(4186*2)/fs;
b=fir1(2000,cutOff);
y=conv(y,b);

%Generación de las notas, de A0 a C8
r=2^(1/12);
notas=zeros(1,88);
k=2; %Cominenzo a agregarlas al vector desde la segunda posición, la primera corresponde a un silencio
notas(1)=0;
for i=-48:39
    notas(k)=440*(r^(i));
    k=k+1;
end

X=zeros(1,16); %Guarda las frecuencias de las notas finales
numN=zeros(1,2); %Indica cuando comienza cada ventana

%Asigno los tiempos entre ventanas
%Se toma una pequeña cantidad de muestras hacia atrás
for i=1:length(picos)
   if(locs(picos(i))<=1024)
      numN(i)=locs(picos(i)); 
   else
      numN(i)=round(locs(picos(i)))-1024; %De la posición del pico, tomo 1024 muestras atrás
   end
end

%Agrego el final
numN(length(numN)+1)=length(t);

k=1; %Indice para indicar la posición para agregar la nueva nota

%Auxiliares para calcular la banda de frecuencia
[s,w,t]=spectrogram(y,256,0,2048,fs,'yaxis');
maxEnergia=max(abs(s));
minF=4000;
maxF=0;

Tiempo=zeros(1); %Vector que guarda los tiempos en que son tocadas las notas

freq=linspace(0,65535,65536)*(fs/65536);
freq=freq(1:length(freq)/2); %Vector de frecuencias, hasta 22050, para graficar fft

frecsAnt2=zeros(1); %Vectores para guardad memoria de las notas pasadas
frecsAnt1=zeros(1); 
for j=1:length(numN)-1 %El ciclo recorrerá n ventanas
    aux=y(numN(j):numN(j+1));
    f=fft(aux,65536);
    f=abs(f);
    f=f(1:length(f)/2); %Tomo la mitad
    
    %Obtención de los picos de frecuencia
    [M,I,~,prm]=findpeaks(f,'MinPeakDistance',14); %Se obtiene la energía y el índice de la máxima energía en la ventana
    [B,i] = sort(prm,'descend');
    
    %Auxiliar, obtiene la energía del mayor pico
    Km=max(f);
    
    %Tomo los 10 picos de mayor altura
    picos=i(1:10);
    picos=sort(picos,'ascend');
    
    
    F0Armonicos=zeros(1); %Vector que guarda las frecuencias de los picos
    contArm=1; %Cuenta el número de frecuencias a probar
    for i=1:10
        if(M(picos(i))>0.25*Km) %Filtra los picos que tienen menos de k energía del pico mayor
            F0Armonicos(contArm)=I(picos(i));
            contArm=contArm+1;
        end
    end
    
    NotasSimultaneas=zeros(1); %Vector auxiliar, por si en una ventana se tocan múltiples notas
    cont=1; %Cuenta el número de notas tocadas simultáneamente
   
    for(i=1:length(F0Armonicos)) %Ciclo que repasa las n frecuencias candidatas
        mn=0; %Bandera, si es 1 indica que es armónico
        if(cont>1)
           m=1; 
           while(mn==0 && m<=length(NotasSimultaneas)) %Recorre el vector de notas simultáneas que va guardando las frecuencias únicas
              aux=round(F0Armonicos(i)/NotasSimultaneas(m)); %Verifica si es múltiplo
              if(abs(aux*NotasSimultaneas(m)-F0Armonicos(i))<=5) %Considero +-5Hz de error
                  mn=1;
              end
              m=m+1;
           end
        end
        if(j>1&&mn==0) %Si se trata de la segunda ventana en adelante
               m=1;
            while(mn==0 && m<=length(frecsAnt1)) %Verifica que no sea una nota pasada
                   aux=round(F0Armonicos(i)/frecsAnt1(m));
                   if(abs(aux*frecsAnt1(m)-F0Armonicos(i))<=5)
                       aux2=y(numN(j-1):numN(j));
                       f2=fft(aux2,65536);
                       f2=abs(f2);
                       rango=(f2(aux*frecsAnt1(m)-5:aux*frecsAnt1(m)+5));
                       if(max(rango)>=f(F0Armonicos(i))) %Verifica la energía comparada a la pasada
                            mn=1;
                       end
                   end
                   m=m+1;
            end
        end
        if(j>2&&mn==0) %Si se trata de la tercera ventana en adelante
               m=1;
            while(mn==0 && m<=length(frecsAnt2)) %Verifica que no sea una nota pasada
                   aux=round(F0Armonicos(i)/frecsAnt2(m));
                   if(abs(aux*frecsAnt2(m)-F0Armonicos(i))<=5)
                       aux2=y(numN(j-2):numN(j-1));
                       f2=fft(aux2,65536);
                       f2=abs(f2);
                       rango=(f2(aux*frecsAnt2(m)-5:aux*frecsAnt2(m)+5));
                       if(max(rango)>=f(F0Armonicos(i))) %Verifica la energía comparada a la pasada
                            mn=1;
                       end
                   end
                   m=m+1;
            end
        end
        if(mn==0) %Si mn=0, se trata de una nota
               X(1,k)=F0Armonicos(i);
               Tiempo(k)=numN(j);
               NotasSimultaneas(cont)=F0Armonicos(i);
               k=k+1;
               cont=cont+1;
        end
       
    end
    
    %Obtiene el ancho de banda de frecuencias
    if M>.707*maxEnergia
       if w(I)>maxF
           maxF=w(I);
       end
       if w(I)<minF
           minF=w(I);
       end
    end
    
    %Guardo las notas detectadas en la ventana
    if(NotasSimultaneas(1)>0)
        if(j>1)
            frecsAnt2=frecsAnt1;
        end
        frecsAnt1=NotasSimultaneas; 
    end
    
end

Ancho=(minF+"-"+maxF);
fprintf('Ancho de banda = %s Hz\n',Ancho)

%Imprime las frecuencias fundamentales
X
%Imprime los tiempos en que fueron tocadas
Tiempo

nota=knnsearch(transpose(notas),transpose(X)); %Para cada frecuencia fundamental extraída, ubica la frecuencia de la nota de piano más cercana

NotaF=["Silencio" "A0" "A0#" "B0" "C1" "C1#" "D1" "D1#" "E1" "F1" "F1#" "G1" "G1#" "A1" "A1#" "B1" "C2" "C2#" "D2" "D2#" "E2" "F2" "F2#" "G2" "G2#" "A2" "A2#" "B2" "C3" "C3#" "D3" "D3#" "E3" "F3" "F3#" "G3" "G3#" "A3" "A3#" "B3" "C4" "C4#" "D4" "D4#" "E4" "F4" "F4#" "G4" "G4#" "A4" "A4#" "B4" "C5" "C5#" "D5" "D5#" "E5" "F5" "F5#" "G5"  "G5#" "A5" "A5#" "B5" "C6" "C6#" "D6" "D6#" "E6" "F6" "F6#" "G6" "G6#" "A6" "A6#" "B6" "C7" "C7#" "D7" "D7#" "E7" "F7" "F7#" "G7" "G7#" "A7" "A7#" "B7" "C8"];
melodia=strings([1,16]); 

nota=transpose(nota);
n=1;
while n<=length(nota) %Asigno el nombre de la nota a las frecuencias
    melodia(n)=NotaF(nota(n));
    n=n+1;
end
%Imprime las notas
melodia