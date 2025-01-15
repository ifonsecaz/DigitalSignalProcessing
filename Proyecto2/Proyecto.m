%partitura=imcomplement(rgb2gray(imread("fur_elise_1.JPG")));
partitura=imcomplement(rgb2gray(imread("turkish_march.JPG")));
imshow(partitura)

[rows, columns, n]=size(partitura); 
largo=round(columns/9);

%Localizar las lineas
posLineas=zeros(40,8);
for i=1:8
    
    numLineas=0;
    a=largo*i;
    j=1;
    while j<=rows
        if(partitura(j,a)==255)
            numLineas=numLineas+1;
            posLineas(numLineas,i)=j;
            while(partitura(j,a)==255)
                j=j+1;
            end
        else
            j=j+1;
        end
        
    end
end

%Ubicacion aprox
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

%Cortar
i=1;
ant=ubicacionFinal(1);
inicio=0;
fin=0;
numDiv=1;

mkdir Lineas

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

%Eliminar bordes negros
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
    figure
    imshow(segmento(:,(inicio-2:fin+2)))
end

%EjComp
segmento=imread(sprintf('Lineas/ManoIzq%d.jpg',i));
[rows, columns, n]=size(segmento); 
llave=segmento(:,(1:round(columns/15)));
figure
imshow(llave)
may=0;
escala=0;

[rowsObj, columnsObj, n]=size(llave);

comp=imread("Notas/Clave/ClaveFa.png");
[rows, columns, numberOfColorChannels]=size(comp);
if numberOfColorChannels>1
    comp=rgb2gray(comp);
end
comp=imcomplement(comp);

for i=0.3:0.1:1
    J = imresize(comp,i);
    [rows, columns, n]=size(J);
    if rows<=rowsObj && columns<=columnsObj
        fila=round((rowsObj-rows)/2);
        colum=round((columnsObj-columns)/2);
        J=padarray(J,[fila colum],0);
    
        c1=normxcorr2(llave,J);
      
        if(max(c1(:))>may)
            escala=i;
            may=max(c1(:));
        end
    end
end
figure
imshow(imresize(comp,escala))


%EjComp
segmento=imread('Lineas/ManoDer1.jpg');
[rows, columns, n]=size(segmento); 
llave=segmento(:,(1:round(columns/15)));
figure
imshow(llave)
may2=0;
escala2=0;

[rowsObj, columnsObj, n]=size(llave);

comp=imread("Notas/Clave/ClaveSol.png");
[rows, columns, numberOfColorChannels]=size(comp);
if numberOfColorChannels>1
    comp=rgb2gray(comp);
end
comp=imcomplement(comp);
for i=0.3:0.1:.6
    J = imresize(comp,i);
    [rows, columns, n]=size(J);
    if rows<=rowsObj && columns<=columnsObj
        fila=round((rowsObj-rows)/2);
        colum=round((columnsObj-columns)/2);
        J=padarray(J,[fila colum],0);
    
        c1=normxcorr2(llave,J);

        if(max(c1(:))>may2)
            escala2=i;
            may2=max(c1(:));
        end
    end
end
figure
imshow(imresize(comp,escala2))

%Tiempos

segmento=imread('Lineas/ManoDer1.jpg');
[rows, columns, n]=size(segmento); 
llave=segmento(:,(round(columns/15):2*round(columns/20)));
figure
imshow(llave)

may2=0;
escala2=0;
tiempo="";



Tiempos=["22","24","34","38","44","68","98","128"];
for m=1:length(Tiempos)
    comp=imread("Notas/Tiempo/"+Tiempos(m)+".png");
    [rowsObj, columnsObj, numberOfColorChannels]=size(comp);
    if numberOfColorChannels>1
        comp=rgb2gray(comp);
    end
    comp=imcomplement(comp);
    for i=0.3:0.1:.6
        J = imresize(comp,i);
        [rows, columns, n]=size(J);
        if rows<=rowsObj && columns<=columnsObj
            fila=round((rowsObj-rows)/2);
            colum=round((columnsObj-columns)/2);
            J=padarray(J,[fila colum],0);
            J=imresize(J,[rowsObj columnsObj]);
            c1=corr2(comp,J);
            Tiempos(m)
            i

            if(c1>may2)
                escala2=i;
                may2=c1;
                tiempo=Tiempos(m);
            end
        end
    end
end

tiempo
