%Telescope
%Detección de notas

%Para analizar theme1 cambiar línea 10, quitar comentario a las líneas 28 y
%34, comentar líneas 32 y 35
%Para analizar theme2 cambiar línea 10, quitar comentario a las líneas 32 y
%35, comentar líneas 28 y 34

%Lectura del audio
[y, fs]=audioread('theme2.wav'); 
t=(0:1:length(y)-1)/fs; %Vector de tiempo

fprintf('Duración = %f segundos\n',max(t))
fprintf('Frecuencia de muestreo = %f\n',fs)

%Gráfica de la señal de audio en el dominio del tiempo
plot(y);
xlabel('Tiempo [s]')
ylabel('Amplitud')
title('Theme Dominio del tiempo')

%Separación en ventanas
yAux=movmean(abs(y),256); %Suavizado de la señal

figure
[pks,locs,~,prm] = findpeaks(yAux,'MinPeakDistance',12000);
[B,i] = sort(prm,'descend');
%plot(1:numel(yAux),yAux,'-',locs(i(1:16)),yAux(locs(i(1:16))),'o ')
%Grafica los picos de Theme1
%Grafica los picos de Theme2
plot(1:numel(yAux),yAux,'-',locs(i(1:49)),yAux(locs(i(1:49))),'o ')

%Obtención de los n picos más altos
%picos=i(1:16); %Usar para Theme1
picos=i(1:49); %Usar para Theme2
picos=sort(picos,'ascend');

%Filtros paso bajas y altas
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
numN=zeros(1,16); %Indica cuando comienza cada ventana

%Asigno los tiempos entre ventanas
for i=1:length(picos)
   numN(i)=round(locs(picos(i)))-1024; %De la posición del pico, tomo 1024 muestras atrás
end

%Elimino el ruido inicial
if(numN(1)<=0)
    Inicio=1;
else
    Inicio=numN(1);
end

%Para el ciclo, retiro el primer elemento y agrego el final
numN=numN(2:length(numN));
numN(length(numN)+1)=length(t);

k=1; %Indice para indicar la posición para agregar la nueva nota

%Auxiliares para calcular la banda de frecuencias
maxEnergia=max(abs(s));
minF=4000;
maxF=0;

Tiempo=zeros(1); %Vector que guarda los tiempos en que son tocadas las notas

freq=linspace(0,65535,65536)*(fs/65536);
freq=freq(1:length(freq)/2); %Vector de frecuencias, hasta 22050, para graficar fft

for j=1:length(numN) %El ciclo recorrerá n ventanas
    %Indica donde inicia la ventana
    if(j==1)
        rangoI=Inicio;
    else
        rangoI=numN(j-1);
    end
    
    %Calculo la fft, de la ventana
    aux=y(rangoI:numN(j));
    f=fft(aux,65536);
    f=abs(f);
    f=f(1:length(f)/2); %Tomo la mitad
    
    %Obtención de los picos de frecuencia
    [M,I,~,prm]=findpeaks(f,'MinPeakDistance',14); %Se obtiene la energía y el índice de la máxima energía en la ventana
    [B,i] = sort(prm,'descend');
    %figure
    %plot(1:numel(f),f,'-',I(i(1:10)),f(I(i(1:10))),'o ')
    
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
    
    F0Armonicos
    
    NotasSimultaneas=zeros(1); %Vector auxiliar, por si en una ventana se tocan múltiples notas
    cont=1; %Cuenta el número de notas tocadas simultáneamente
    
    for(i=1:length(F0Armonicos)) %Ciclo que repasa las n frecuencias candidatas
        mn=0; %Bandera, si es 1 indica que es armónico
        if(j>1) %Si se trata de la segunda ventana en adelante
               m=1;
            while(mn==0 && m<=length(frecsAnt1)) %Verifica que no sea una nota pasada
                   aux=round(F0Armonicos(i)/frecsAnt1(m));
                   if(abs(aux*frecsAnt1(m)-F0Armonicos(i))<=5)
                       mn=1;
                   end
                   m=m+1;
            end
        end
        if(j>2) %Si se trata de la tercera ventana en adelante
               m=1;
            while(mn==0 && m<=length(frecsAnt2)) %Verifica que no sea una nota pasada
                   aux=round(F0Armonicos(i)/frecsAnt2(m));
                   if(abs(aux*frecsAnt2(m)-F0Armonicos(i))<=5)
                       aux2=y(numN(j-2):numN(j-1));
                       f2=fft(aux2,65536);
                       f2=abs(f2);
                       if(f2(aux*frecsAnt2(m))>=f(F0Armonicos(i))) %Verifica la energía comparada a la pasada
                            mn=1;
                       end
                   end
                   m=m+1;
            end
        end
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
        if(mn==0) %Si mn=0, se trata de una nota
               X(1,k)=F0Armonicos(i);
               Tiempo(k)=rangoI;
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

Tiempo