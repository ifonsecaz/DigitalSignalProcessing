function [dur,fms,yTest,yAuxT,locsT,picosT,frecs,tiempos,maxT,melodia,Ancho,nota] = PicosNotasFun(audioFile)

%Telescopefr
%Deteccion de notas

%Lectura del audio
[y, fs]=audioread(audioFile); 
y=y(:,1); %Tomo el primer canal
t=(0:1:length(y)-1)/fs; %Vector de tiempo

dur = max(t);
fms = fs;

%Grafica de la senal de audio en el dominio del tiempo
% plot(y);
% xlabel('Tiempo [s]')
% ylabel('Amplitud')    

% title('Theme Dominio del tiempo')

yTest = y;

%Separacion en ventanas
yAux=movmean(abs(y),1024); %Suavizado de la senal

%FindPeaks, detecta los picos de la senal, con una distancia minima entre
%picos de k muestras
%Para elegir la distancia, inicialmente se probo con 12000 muestras,
%mediante la formula fs/f, f de los bpm, se modifica el tamano de las
%ventanas
%Se eligio 13363.63 como tamaño mínimo de las ventanas, corresponde a 200
%bpm
[pks,locs,~,prm] = findpeaks(yAux,'MinPeakDistance',10000); %12000 muestras de distancia, tomo 44100 muestras en un segundo 
%[pks,locs,~,prm] = findpeaks(yAux,'MinPeakDistance',fs/3.3); %13363.63 para bpm=200, hasta 147000 para bpm=20;
%pks es la energia de los picos, locs el indice, prm la prominencia
[B,i] = sort(prm,'descend'); %Se ordenan los picos segun su prominencia
%figure
%plot(1:numel(yAux),yAux,'-',locs(i),yAux(locs(i)),'o ') %grafica antes de
%filtrarlos por su prominencia

%Filtrado por su prominencia
%Se queda con los picos que tengan al menos el 10% de la prominencia del
%maximo
picos=zeros(1);
contP=1;
maxProm=max(prm);
for f=1:length(B)
    if(B(f)>=.1*maxProm)
        picos(contP)=i(f);
        contP=contP+1;
    end
end
%figure
%plot(1:numel(yAux),yAux,'-',locs(picos),yAux(locs(picos)),'o ') %Grafica de los picos elegidos  

picosT = picos;
yAuxT = yAux;
locsT = locs;

picos=sort(picos,'ascend');

%Filtros paso bajas y altas
%Para eliminar algunas inconsistencias de la senal
%27.5 es la frecuencia minima del piano
%4186 es la frecuencia maxima del piano
cutOff=(27.5*2)/fs;
b=fir1(2000,cutOff,'high');
y=conv(y,b);

cutOff=(4186*2)/fs;
b=fir1(2000,cutOff);
y=conv(y,b);

%Generacion de las notas, de A0 a C8
r=2^(1/12);
notas=zeros(1,88);
k=2; %Cominenzo a agregarlas al vector desde la segunda posicion, la primera corresponde a un silencio
notas(1)=0;
for i=-48:39
    notas(k)=440*(r^(i));
    k=k+1;
end

X=zeros(1,16); %Guarda las frecuencias de las notas finales
numN=zeros(1,2); %Indica cuando comienza cada ventana

%Asigno los tiempos entre ventanas
%Se toma una pequena cantidad de muestras hacia atras
for i=1:length(picos)
   numN(i)=round(locs(picos(i))); 
end

%Agrego el final
numN(length(numN)+1)=length(t);

k=1; %Indice para indicar la posicion para agregar la nueva nota

maxT=length(t);

Tiempo=zeros(1); %Vector que guarda los tiempos en que son tocadas las notas

freq=linspace(0,65535,65536)*(fs/65536);
freq=freq(1:length(freq)/2); %Vector de frecuencias, hasta 22050, para graficar fft

frecsAnt2=zeros(1); %Vectores para guardad memoria de las notas pasadas
frecsAnt1=zeros(1); 
for j=1:length(numN)-1 %El ciclo recorrera n ventanas
    aux=y(numN(j):numN(j+1));
    f=fft(aux,65536);
    f=abs(f);
    f=f(1:length(f)/2); %Tomo la mitad
    
    %Obtencion de los picos de frecuencia
    [M,I,~,prm]=findpeaks(f,'MinPeakDistance',14); %Se obtiene la energia y el indice de la maxima energia en la ventana
    [B,i] = sort(prm,'descend');
  
    %Auxiliar, obtiene la energia del mayor pico
    Km=max(f);
    
    %Tomo los 15 picos de mayor altura
    picos=i(1:15);
    picos=sort(picos,'ascend');
    
    
    F0Armonicos=zeros(1); %Vector que guarda las frecuencias de los picos
    contArm=1; %Cuenta el numero de frecuencias a probar
    for i=1:15
        if(M(picos(i))>0.25*Km) %Filtra los picos que tienen menos de k energia del pico mayor
            F0Armonicos(contArm)=I(picos(i));
            contArm=contArm+1;
        end
    end
    
    NotasSimultaneas=zeros(1); %Vector auxiliar, por si en una ventana se tocan multiples notas
    cont=1; %Cuenta el numero de notas tocadas simultaneamente
   
    for(i=1:length(F0Armonicos)) %Ciclo que repasa las n frecuencias candidatas
        mn=0; %Bandera, si es 1 indica que es armonico
        if(cont>1)
           m=1; 
           while(mn==0 && m<=length(NotasSimultaneas)) %Recorre el vector de notas simultaneas que va guardando las frecuencias unicas
              aux=round(F0Armonicos(i)/NotasSimultaneas(m)); %Verifica si es multiplo
              if(abs(aux*NotasSimultaneas(m)-F0Armonicos(i))<=15) %Considero +-15Hz de error
                  mn=1;
              end
              m=m+1;
           end
        end
        
        if(j>1&&mn==0) %Si se trata de la segunda ventana en adelante
               m=1;
            while(mn==0 && m<=length(frecsAnt1)) %Verifica que no sea una nota pasada
                   aux=round(F0Armonicos(i)/frecsAnt1(m));
                   if(abs(aux*frecsAnt1(m)-F0Armonicos(i))<=15)
                       aux2=y(numN(j-1):numN(j));
                       f2=fft(aux2,65536);
                       f2=abs(f2);
                       rango=(f2(aux*frecsAnt1(m)-15:aux*frecsAnt1(m)+15)); 
                       if(max(rango)>=f(F0Armonicos(i))||f2(frecsAnt1(m))>f(F0Armonicos(i))) %Verifica la energia comparada a la pasada
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
                   if(abs(aux*frecsAnt2(m)-F0Armonicos(i))<=15)
                       aux2=y(numN(j-2):numN(j-1));
                       f2=fft(aux2,65536);
                       f2=abs(f2);
                       rango=(f2(aux*frecsAnt2(m)-15:aux*frecsAnt2(m)+15));
                       if(max(rango)>=f(F0Armonicos(i))||f2(frecsAnt2(m))>f(F0Armonicos(i))) %Verifica la energia comparada a la pasada
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
    
    %Guardo las notas detectadas en la ventana
    if(NotasSimultaneas(1)>0)
        if(j>1) 
            frecsAnt2=frecsAnt1;
        end
        frecsAnt1=NotasSimultaneas; 
    end
    
end

%Imprime los tiempos en que fueron tocadas
tiempos=Tiempo;

nota=knnsearch(transpose(notas),transpose(X)); %Para cada frecuencia fundamental extraída, ubica la frecuencia de la nota de piano más cercana

NotaF=["Silencio" "A0" "A0#" "B0" "C1" "C1#" "D1" "D1#" "E1" "F1" "F1#" "G1" "G1#" "A1" "A1#" "B1" "C2" "C2#" "D2" "D2#" "E2" "F2" "F2#" "G2" "G2#" "A2" "A2#" "B2" "C3" "C3#" "D3" "D3#" "E3" "F3" "F3#" "G3" "G3#" "A3" "A3#" "B3" "C4" "C4#" "D4" "D4#" "E4" "F4" "F4#" "G4" "G4#" "A4" "A4#" "B4" "C5" "C5#" "D5" "D5#" "E5" "F5" "F5#" "G5"  "G5#" "A5" "A5#" "B5" "C6" "C6#" "D6" "D6#" "E6" "F6" "F6#" "G6" "G6#" "A6" "A6#" "B6" "C7" "C7#" "D7" "D7#" "E7" "F7" "F7#" "G7" "G7#" "A7" "A7#" "B7" "C8"];
melodia=strings([1,16]); 
frecuencias=zeros([1,2]);


nota=transpose(nota);
n=1;
while n<=length(nota) %Asigno el nombre de la nota a las frecuencias
    melodia(n)=NotaF(nota(n));
    frecuencias(n)=notas(nota(n));
    n=n+1;
end
%Da las frecuencias correspondientes a las notas
frecs=frecuencias;

%Calcula el ancho de banda
Ancho=(min(frecs)+"-"+max(frecs));
%fprintf('Ancho de banda = %s Hz\n',Ancho)

%Imprime las notas
%melodia;

end
