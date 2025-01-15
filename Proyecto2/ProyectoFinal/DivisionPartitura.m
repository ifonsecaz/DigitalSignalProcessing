function [numDivisiones] = DivisionPartitura(archivo)

    %partitura=imcomplement(rgb2gray(imread("fur_elise_1.JPG")));
    %partitura=imcomplement(rgb2gray(imread("turkish_march.JPG")));
    partitura=imcomplement(rgb2gray(imread(archivo))); %Lee y convierte la partitura a blanco y negro
    imshow(partitura) 

    [rows, columns, n]=size(partitura); 
    
    %Para localizar las líneas, se parte la partitura en 9 fragmentos, en
    %cada columna se contará el número de líneas que aparecen
    largo=round(columns/9);

    %Localizar las lineas
    posLineas=zeros(40,8);
    for i=1:8

        numLineas=0;
        a=largo*i; 
        j=1;
        while j<=rows
            if(partitura(j,a)==255) %Se recorren las filas, cuando encuentra un valor de 255 lo reconoce como una línea
                numLineas=numLineas+1;
                posLineas(numLineas,i)=j;
                while(partitura(j,a)==255) %Mientras no cambie de valor sigue estando sobre la misma línea
                    j=j+1;
                end
            else
                j=j+1;
            end

        end
    end
    %Detectará como línea cualquier recuadro blanco, se deben filtrar
    
    %Se observa el arreglo, y cuando la ubicación de las filas donde
    %debería haber una línea coincide en 3 o más columnas se considera que
    %es una línea del pentagrama
    %Error
    e=floor(rows*0.05);
    ubicacionFinal=zeros(1,2);
    num=1;
    for i=1:8
        m=length(posLineas(:,i));
        for k=1:m
            val=posLineas(k,i);
            count = sum(posLineas(:)==val);
            if(count>=3)
                ubicacionFinal(1,num)=val;
                num=num+1;
            end
        end
    end
    ubicacionFinal=unique(ubicacionFinal);
    ubicacionFinal=ubicacionFinal(2:end);

    %Se separa la partitura en diferentes pentagramas y se guardan en un
    %folder
    i=1;
    ant=ubicacionFinal(1);
    numDiv=1;
    
    if isfolder("Lineas")
       rmdir Lineas s
    end
    mkdir Lineas
    
    %Para la separación considera cierto error, en caso de no detectar
    %todas las líneas del pentagrama, se considera que son equidistantes y
    %se toman en total 9 líneas, considerando las notas fuera del
    %pentagrama
    while i<length(ubicacionFinal)
        inicio=ubicacionFinal(i)-e;
        while(i<length(ubicacionFinal)&&abs(ubicacionFinal(i)-ant)<=20)
            ant=ubicacionFinal(i);
            i=i+1;
        end
        fin=ubicacionFinal(i-1)+e;
        ant=ubicacionFinal(i);
        img=partitura((inicio:fin),:);
        if mod(numDiv,2)==0
            imwrite(img,sprintf('Lineas/ManoIzq%d.jpg',numDiv))
        else
            imwrite(img,sprintf('Lineas/ManoDer%d.jpg',numDiv))
        end
        numDiv=numDiv+1;
    end

    %Eliminar bordes negros, se quita el inicio y fin del pentagrama, solo
    %toma a partir de que aparece un algo blanco
    for i=1:numDiv-1
        if mod(i,2)==0
            segmento=imread(sprintf('Lineas/ManoIzq%d.jpg',i));
        else
            segmento=imread(sprintf('Lineas/ManoDer%d.jpg',i));
        end

        [rows, columns, n]=size(segmento); 

        j=1;
        while (j<=columns && segmento(round(rows/2),j)<=200)
            j=j+1;
        end

        inicio=j;

        j=1;
        while (j<=columns && segmento(round(rows/2),columns-j)<=200)
            j=j+1;
        end

        fin=columns-j;

        if mod(i,2)==0
            imwrite(segmento(:,(inicio-2:fin+2)),sprintf('Lineas/ManoIzq%d.jpg',i))
        else
            imwrite(segmento(:,(inicio-2:fin+2)),sprintf('Lineas/ManoDer%d.jpg',i))
        end
        %figure
        %imshow(segmento(:,(inicio-2:fin+2)))
    end
    
    %Eliminar líneas del pentagrama
    %Localizar las lineas
    for mn=1:numDiv-1
        if mod(mn,2)==0
            pentagrama=imread(sprintf('Lineas/ManoIzq%d.jpg',mn));
        else
            pentagrama=imread(sprintf('Lineas/ManoDer%d.jpg',mn));
        end
        [rows, columns, n]=size(pentagrama); 
        largo=round(columns/10);
        posLineas=zeros(15,9);
        for i=1:9
            numLineas=0;
            a=largo*i;
            j=1;
            while j<=rows
                if(pentagrama(j,a)>=100)
                    numLineas=numLineas+1;
                    posLineas(numLineas,i)=j;
                    while(j<=rows && pentagrama(j,a)>=100)
                        j=j+1;
                    end
                else
                    j=j+1;
                end

            end
        end

        %Ubicacion aprox
        ubicacionFinal=zeros(1,2);
        num=1;
        for i=1:9
            m=length(posLineas(:,i));
            for k=1:m
                val=posLineas(k,i);
                count = sum(posLineas(:)==val);
                if(count>=4)
                    ubicacionFinal(1,num)=val;
                    num=num+1;
                end
            end
        end
        ubicacionFinal=unique(ubicacionFinal);
        ubicacionFinal=ubicacionFinal(2:end);
        
        espacio=ubicacionFinal(3)-ubicacionFinal(2);
        
        [row,col]=find(posLineas==ubicacionFinal(3));
        recorrer=ubicacionFinal(3);
        while pentagrama(recorrer,largo*col)>100
           recorrer=recorrer+1; 
        end
        ancho=recorrer-ubicacionFinal(3);
    
        %Borrar lineas
        ubicacion=ubicacionFinal(3)-((4)*(espacio));
        pentagrama((ubicacion:ubicacion+ancho),:)=0;
        ubicacion=ubicacionFinal(3)-((3)*(espacio));
        pentagrama((ubicacion:ubicacion+ancho),:)=0;
        ubicacion=ubicacionFinal(3)+((4)*(espacio));
        pentagrama((ubicacion:ubicacion+ancho),:)=0;
        ubicacion=ubicacionFinal(3)+((3)*(espacio));
        pentagrama((ubicacion:ubicacion+ancho),:)=0;
        pentagrama((ubicacion:ubicacion+ancho),:)=0;
        for lin=1:5
           pentagrama((ubicacionFinal(lin):ubicacionFinal(lin)+ancho),:)=0;
        end
        if mod(mn,2)==0
            imwrite(pentagrama,sprintf('Lineas/SPManoIzq%d.jpg',mn))
        else
            imwrite(pentagrama,sprintf('Lineas/SPManoDer%d.jpg',mn))
        end
        %figure
        %imshow(pentagrama)
    end 
    
    %Lectura del compás
    segmento=imread('Lineas/SPManoDer1.jpg');
    [rows, columns, n]=size(segmento); 
    llave=segmento(:,(round(columns/15):2*round(columns/20)));
    
    may2=0;
    escala2=0;
    tiempo='';


    %Se tiene en un folder imágenes de los diferentes tiempos
    %Se toma cada uno se rescala a .25 y .3 para comparar
    Tiempos=["22","24","34","38","44","68","98","128"];
    for m=1:length(Tiempos)
        comp=im2bw(imread("Tiempo/"+Tiempos(m)+".png"));
        [rowsObj, columnsObj, numberOfColorChannels]=size(llave);
        %if numberOfColorChannels>1
         %   comp=rgb2gray(comp);
        %end
        comp=imcomplement(comp);
        %Se ajusta el tamaño del tiempo a comparar
        for i=0.25:0.05:.3
            J = imresize(comp,i);
            [rows, columns, n]=size(J);
            if rows<=rowsObj
                if mod(rowsObj-rows,2)==1
                    aux=zeros(rows+1,columns);
                    aux(1:rows,:)=J;
                    J=aux;
                end
                fila=floor((rowsObj-rows)/2);
                J=padarray(J,[fila 0],0);
            end
            if columns<=columnsObj
                [rows, columns, n]=size(J);
                if mod(columnsObj-columns,2)==1
                    aux=zeros(rows,columns+1);
                    aux(:,1:columns)=J;
                    J=aux;
                end
                colum=floor((columnsObj-columns)/2);
                J=padarray(J,[0 colum],0);
            end
            if columns>columnsObj
                if mod(columns-columnsObj,2)==1
                    J=J(:,(1:columns));
                end
                J=J(:,(floor((columns-columnsObj)/2):columns-floor((columns-columnsObj)/2)));
            end
            if rows>rowsObj
                if mod(rows-rowsObj,2)==1
                    J=J(:,(1:rows));
                end
                J=J(:,(floor((rows-rowsObj)/2):rows-floor((rows-rowsObj)/2)));
            end
            c1=normxcorr2(llave,J);
            %figure
            %imshow(J)
            if(max(c1(:))>may2)
                escala2=i;
                may2=max(c1(:));
                tiempo=char(Tiempos(m));
            end
         
        end
    end
    
    
    %Se extrae información de los tiempos
    if length(tiempo)>2
        temp=str2num(extractAfter(tiempo,2));
        numNotas=str2num(extractBefore(tiempo,3));

    else
        temp=str2num(extractAfter(tiempo,1));
        numNotas=str2num(extractBefore(tiempo,2));

    end
    aux=zeros(numDiv-1,2);
    
    
    %Reconocimiento de las barras verticales
    %Sobre las imágenes con líneas, se cuenta en cada columna el número de
    %pixeles blancos
    for i=1:numDiv-1
        if mod(i,2)==0
            segmento=imread(sprintf('Lineas/ManoIzq%d.jpg',i));
        else
            segmento=imread(sprintf('Lineas/ManoDer%d.jpg',i));
        end

        [rows, columns, n]=size(segmento); 

        aux2=zeros(1,columns);
        
        for j=1:columns
            A=sum(segmento(:,j)>=200);
            aux2(1,j)=A;
        end
        
        %Extrae los mayores, al considerar que las barras paralelas pueden
        %tener un mayor ancho, si detecta un máximo consecutivo se ignora
        [b,Ind]=maxk(aux2,2*(temp+1));
        
        Ind=sort(Ind);
        
        for h=1:length(Ind)-1
           if Ind(h)+1==Ind(h+1)
              aux2(Ind(h+1))=0; 
           end
        end
        
        c=max(b);
        
        
        [b,Ind]=maxk(aux2,temp+1);
        
        %Toma como barras verticales aquellas que superan el 75% del máximo
        %de pixeles blancos
        for(km=1:length(Ind))
            if (b(km)>=0.75*c)
                aux(i,km)=Ind(km);
            end
        end
        aux(i,:)=sort(aux(i,:));
    end
    
    [a,numBarras,c]=size(aux);
    
    if isfolder('Notas')
       rmdir Notas s
    end
    mkdir Notas;
    notasIzq=1;
    notasDer=1;
    
    %Extraer notas
    %A partir de la localización de las barras verticales, el pentagrama se
    %divide en partes iguales, según los tiempos
    for i=1:numDiv-1
        for j=1:numBarras-1
            if mod(i,2)==0
                segmento=imread(sprintf('Lineas/ManoIzq%d.jpg',i));
            else
                segmento=imread(sprintf('Lineas/ManoDer%d.jpg',i));
            end
            [rows, column, numC]=size(segmento);
            
            inicio=aux(i,j);
            fin=aux(i,j+1);
            
            %Considera como casos especiales, el primer compás en cada
            %pentagrama, en todos se debe quitar la clave, y en los
            %primeros 2 el compás
            if j==1
                if i<=2
                    inicio=2*round(column/20);
                    espacio=round((fin-inicio)/(numNotas));
                    %inicio=inicio+round((fin-inicio)/(numNotas));
                else
                    inicio=round(column/15);
                    espacio=round((fin-inicio)/(numNotas));
                    %inicio=inicio+espacio;
                end
            else
                espacio=round((fin-inicio)/numNotas);
            end
           
           
            for k=1:numNotas
                if mod(i,2)==0
                    
                    desde=inicio+espacio*(k-1)-round(0.2*espacio);
                    hasta=inicio+espacio*k-round(0.2*espacio);
               
                    imwrite(segmento(:,(desde:hasta)),sprintf('Notas/I%d.jpg',notasIzq))
                    notasIzq=notasIzq+1;
                else
                    
                    desde=inicio+espacio*(k-1)-round(0.2*espacio);
                    hasta=inicio+espacio*k-round(0.2*espacio);

                    imwrite(segmento(:,(desde:hasta)),sprintf('Notas/D%d.jpg',notasDer))
                    notasDer=notasDer+1;
                end
            end
        end
    end
    numDivisiones=notasDer-1; %Número de notas
    
    
end
