function [tiempos,tfinal,fs] = VectorTiempos(simultaneas,bpm,numDivisiones)    
    fs=44100;
    NotasPorSegundo=bpm/60;
    EspacioEntreNotas=fs/NotasPorSegundo;
    tfinal=(numDivisiones+1)*EspacioEntreNotas;
    
    tiempos=zeros(1,2);
    
    k=1;
    for i=1:numDivisiones
       rep=simultaneas(i);
       
       for j=1:rep
          tiempos(1,k)=EspacioEntreNotas*(i);
          k=k+1;
       end
    end
    
end