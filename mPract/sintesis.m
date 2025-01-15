notas=[219 328 437 521];
duracion=[327 327 20473 42713];
fs=44100;
tfinal=62521;

tiempos=unique(duracion);
    tiempos(length(tiempos)+1)=tfinal;
    
    
    
    j=1;
    musica=zeros(1);
    F3=[];
    for(i=1:length(tiempos)-1)
        tiempoNota=abs(tiempos(i)-tiempos(i+1));
        t=(0:1/fs:tiempoNota/fs);
        
        decaimiento=exp(-t);
        
        InicioNota=tiempos(i);
        sonido=zeros(1,length(t));
        while(j<=length(duracion)&&InicioNota==duracion(j))
            
            nota=notas(j);
            %Consideramos 8 armónicos
            for(k=1:8)
                sonido=exp(-(k-1)*.5)*[sin(nota*k*2*pi*t)]+sonido;
            end
            
            j=j+1;
        end
        sonido=sonido.*decaimiento;
        sonido=sonido/max(sonido);
        F3=[F3;transpose(sonido)];
    end
    F3=F3/max(F3);
    fileName='salida.wav';
    audiowrite(fileName,F3,fs);