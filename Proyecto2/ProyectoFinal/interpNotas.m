function [FrecNotas,Simultaneas] = interpNotas()
  myfolder=dir('Notas');
    %Clave="Sol";
    myfolder=myfolder(3:end);
    fileLenght=length(myfolder);
    myfolderD=myfolder(1:fileLenght/2);
    myfolderI=myfolder(fileLenght/2+1:end);
    notasFinales=1;
    contaTiempos=1;
    Posiciones=posNotas();
    contadorNotas=1;

    Do=[65.5064,73.4162,82.4069,87.3071,97.9998,110,123.471,130.813,...
         146.832,164.814,174.614,195.998,220,246.942,261.626,293.665,329.628,349.228,0];

    DoNotes=["C2","D2","E2","F2","G2","A2","B2","C3","D3","E3","F3","G3","A3","B3","C4","D4","E4","F4"];

    Sol=[220,246.942,261.626,293.665,329.628,349.228,391.995,440,493.883,523.251,...
         587.33,659.255,698.456,783.991,880,987.767,1046.5,1174.66,0];

    SolNotes=["A3","B3","C4","D4","E4","F4","G4","A4","B4","C5","D5","E5","F5","G5","A6","B6","C6","D6"];



    for x=1:fileLenght/2
        fileD=myfolderD(x).name;
        fileI=myfolderI(x).name;

        n=strlength(fileD);
        if n==6
            prelim=str2double(fileD(2));
        else
            prelim=str2double(fileD(2:3));
        end
        prelim;
        fileD=string(fileD);
        fileI=string(fileI);
        folderOrd(prelim*2-1)=fileD;
        folderOrd(prelim*2)=fileI;

   

    end
    folderOrd;
    
    isSilence=CorrelacionSilNot(folderOrd);
 for y=1:length(folderOrd)
    nueva=imread("Notas/"+folderOrd(y));
    %imshow(nueva);
    otra=mean(nueva);
    noteNueva=transpose(nueva);
    [row col]=size(nueva);
    for i=1:col
       
        if otra(i)>70
            nueva(:,i)=0;
        end
    end


    pNueva=mean(noteNueva);
    aux=mean(noteNueva(1:5,:));

    for i=1:length(aux)
      
        if abs(aux(i)-pNueva(i))<20
            noteNueva(:,i)=0;
        end
    end


    %imshow(nueva);
    %imshow(transpose(noteNueva))

    last=transpose(nueva-(nueva-transpose(noteNueva)));
    %imshow(transpose(last))

    ret=transpose(last);
    temp=last;
    for i=1:col-7
        temp=sum(last(i:i+7,:)>30);
        if isempty(find(temp==8))==0
            aux=find(temp==8);
            for j=1:length(aux)
                last(:,aux(j))=0;
            end

        end
    end

    %imshow(transpose(last))
    m=mean(last);
    detect=find(mean(transpose(last))>2);
    j=2;
    cord(1)=1;
    for i=1:length(detect)-1
        if detect(i+1)-detect(i)>7
            pos(j)=i;
            cord(j)=round((detect(i+1)+detect(i))/2);
            j=j+1;
        end

    end

    for i=1:length(cord)
        if i~=length(cord)
            Notas=last(cord(i):cord(i+1),:);
        else
            Notas=last(cord(i):end,:);
        end
        m=mean(Notas);
        for j=1:length(m)
            if m(j)<10
                m(j)=0;
            end
        end
        lugNuevo=find(m);
 %       imshow(imcomplement(transpose(m)));
        aux=lugNuevo;
        if isempty(aux)==0
             for j=2:length(lugNuevo)
                if lugNuevo(j)-lugNuevo(j-1)>4
                    aux(j)=0;
                end
            end
            [~, ~ ,v]=find(aux);
            prom(i)=mean(v);
        else
            prom=0;
        end

    end
    if isSilence(y)==1
       prom=0; 
    end

    prom;
    cord;
  
    cola=length(prom);
    
    if mod(y,2)~=0
        Simultaneas(contaTiempos)=cola;
        if y==1
            notasFinales=prom;
            for t=contadorNotas:length(notasFinales)    
                [~,posi]=min(abs(notasFinales(t)-Posiciones));
                FrecNotas(contadorNotas)=Sol(posi);
                contadorNotas=contadorNotas+1;
            end
        else
            lengthAnt=length(notasFinales);
%             
            notasFinales=[notasFinales, prom];
            for t=lengthAnt+1:length(notasFinales)
                [~,posi]=min(abs(notasFinales(t)-Posiciones));
                FrecNotas(contadorNotas)=Sol(posi);
                contadorNotas=contadorNotas+1 ;
            end
            
        end
        
       
    else
        Simultaneas(contaTiempos)=Simultaneas(contaTiempos)+cola;
        contaTiempos=contaTiempos+1;
%         
        lengthAnt=length(notasFinales);
        notasFinales=[notasFinales, prom];
        for t=lengthAnt+1:length(notasFinales)
            [~,posi]=min(abs(notasFinales(t)-Posiciones));
            FrecNotas(contadorNotas)=Do(posi);
            contadorNotas=contadorNotas+1;
        end
    end
    Simultaneas;
    prom=0;
    cord=0;
    

end
    notasFinales=0;
end

