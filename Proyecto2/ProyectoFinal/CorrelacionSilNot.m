function [isNote] = CorrelacionSilNot(Arreglo)
numDivisiones=length(Arreglo);
isNote=ones(1,numDivisiones);
for k=1:numDivisiones
    %Mano derecha
    nota=imread("Notas/"+Arreglo(k));
    %Van de 1 hasta numDivisiones, estan separadas en dereche e izquierda
    [rows, columns, n]=size(nota); 

    may2=0;
    escala2=0;
    tiempo='';

    Simbolos=["Nota1","Nota2","Nota3","Nota4","Nota5","Nota6","Nota7","Nota8","Nota9","Silencio","Desc","Desc2"];
        for m=1:length(Simbolos)
            comp=im2bw(imread("Simbolos/"+Simbolos(m)+".png"));
            [rowsObj, columnsObj, numberOfColorChannels]=size(nota);
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
                %{
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
                %}
                c1=normxcorr2(nota,J);

                if(max(c1(:))>may2)
                    escala2=i;
                    may2=max(c1(:));
                    tiempo=char(Simbolos(m));
                end

            end
        end
        k;
        tiempo;

%         if (extractBefore(tiempo,2)=='N')
%             %Es una nota
%         else
%             %Es un silencio
%         end
        
%     %Mano Izquierda    
%     nota=imread("Notas/I"+int2str(k)+".jpg");
%     %Van de 1 hasta numDivisiones, estan separadas en dereche e izquierda
%     [rows, columns, n]=size(nota); 
% 
%     may2=0;
%     escala2=0;
%     tiempo='';
% 
%     Simbolos=["Nota1","Nota2","Nota3","Nota4","Nota5","Nota6","Nota7","Nota8","Nota9","Nota10","Silencio","Desc","Desc2"];
%         for m=1:length(Simbolos)
%             comp=im2bw(imread("Notas/Simbolos/"+Simbolos(m)+".png"));
%             [rowsObj, columnsObj, numberOfColorChannels]=size(nota);
%             comp=imcomplement(comp);
%             %Se ajusta el tamaño del tiempo a comparar
%             for i=0.25:0.05:.3
%                 J = imresize(comp,i);
%                 [rows, columns, n]=size(J);
%                 if rows<=rowsObj
%                     if mod(rowsObj-rows,2)==1
%                         aux=zeros(rows+1,columns);
%                         aux(1:rows,:)=J;
%                         J=aux;
%                     end
%                     fila=floor((rowsObj-rows)/2);
%                     J=padarray(J,[fila 0],0);
%                 end
%                 if columns<=columnsObj
%                     [rows, columns, n]=size(J);
%                     if mod(columnsObj-columns,2)==1
%                         aux=zeros(rows,columns+1);
%                         aux(:,1:columns)=J;
%                         J=aux;
%                     end
%                     colum=floor((columnsObj-columns)/2);
%                     J=padarray(J,[0 colum],0);
%                 end
%                 if columns>columnsObj
%                     if mod(columns-columnsObj,2)==1
%                         J=J(:,(1:columns));
%                     end
%                     J=J(:,(floor((columns-columnsObj)/2):columns-floor((columns-columnsObj)/2)));
%                 end
%                 if rows>rowsObj
%                     if mod(rows-rowsObj,2)==1
%                         J=J(:,(1:rows));
%                     end
%                     J=J(:,(floor((rows-rowsObj)/2):rows-floor((rows-rowsObj)/2)));
%                 end
%                 c1=normxcorr2(nota,J);
% 
%                 if(max(c1(:))>may2)
%                     escala2=i;
%                     may2=max(c1(:));
%                     tiempo=char(Simbolos(m));
%                 end
% 
%             end
%         end
%         tiempo
        
        if (extractBefore(tiempo,2)=='N')
            isNote(k)=0;
   
  
        end
    end
end

