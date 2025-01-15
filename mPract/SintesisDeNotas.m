%Telescope
%Síntesis de notas

%Funcion que recibe las frecuencias de las notas, el tiempo en que son tocadas las notas, la
%frecuencia de muestreo y el numero de la ultima muestra
function [Final] = SintesisDeNotas(notas, duracion,fs,tfinal)
    %El vector de duracion contiene los tiempos en que son tocadas cada
    %nota, contiene repetidos si se tocan 2 o mas notas simultaneas
    tiempos=unique(duracion);
    tiempos(length(tiempos)+1)=tfinal; %Agrego el final
    
    j=1; %Contador para recorrer el vector duracion y notas
    F3=[]; %Vector para guardar la señal generada
    guardar=0; %Considera que el sonido de una nota puede estar presente en la siguiente
    for(i=1:length(tiempos)-1)
        tiempoNota=abs(tiempos(i)-tiempos(i+1)); %Obtiene la duracion entre notas
        if tiempoNota>1.5*fs %Considera que la nota puede durar un maximo de 1.5 segundos, despues la rellena con un silencio
            t=(0:1/fs:1.5);
            t2=(0:1/fs:1.5);
            descanso=(0:1/fs:(tiempoNota-1.5*fs)/fs);
            rest=0*[cos(2*pi*descanso)];
        else
            if(tiempoNota>fs) %Para hacer que la nota este presente en la siguiente, se considero una duracion de 1 segundo
                t2=(0:1/fs:tiempoNota/fs); 
            else
                t2=(0:1/fs:1); 
            end
            
            t=(0:1/fs:tiempoNota/fs); %t2 dura un segundo y t es la duracion de la ventana antes de la siguiente nota
            rest=.2;
        end
        decaimiento=exp(-1.5*t2); %Se uso que la nota decae de manera exponencial en el tiempo
        
        InicioNota=tiempos(i);
        sonido=zeros(1,length(t2));
        while(j<=length(duracion)&&InicioNota==duracion(j)) %Recorre cada una de las notas que son tocadas simultaneamente
            
            nota=notas(j);
            %Considera 8 armónicos por nota
            for(k=1:8)
                sonido=(1/(2.5^(k-1)))*[cos(nota*k*2*pi*t2)]+sonido;%
            end
            
            j=j+1;
        end
        
        if(i>1) %Le suma el remanente de la nota anterior
            if(length(t2)>length(guardar))
                aux=guardar;
                aux(numel(sonido))=0;
                sonido=sonido+aux;
            else
                sonido=sonido+guardar(1:length(t2));
            end
        end
        
        sonido=transpose(sonido.*decaimiento); %Multimplica por la senal exponencial para que su volumen caiga
        guardar=transpose(sonido(length(t):length(t2))); %Guarda una parte de la nota que estara presente en la siguiente
        sonido=sonido(1:length(t));
        
        sonido=sonido/max(sonido); 
        F3=[F3;sonido;transpose(rest)]; %Concatena las notas
    end
    F3=F3/max(F3);
    Final=movmean(F3,64); 
    fileName='salida.wav'; 
    audiowrite(fileName,transpose(F3),fs); %Escribe el archivo de salida
end
