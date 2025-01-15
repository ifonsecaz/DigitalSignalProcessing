function [ex1fsX]=SenalError(x1fs0,x1fsX,Fm,FmSub)
    [a,b]=size(x1fs0);
    
    if a>1
        x1fs0=transpose(x1fs0);
    end
    
    [a,b]=size(x1fsX);
    
    if a>1
        x1fsX=transpose(x1fsX);
    end
    
    b=length(x1fs0);
    
    ex1fsX=zeros(1,b);
    
    salto=round(Fm/FmSub);
    
    i=1;
    j=1;
    while i<(b-1)
       ex1fsX(1,i)=x1fsX(j);
       
       j=j+1;
       i=i+salto;
    end
    
    ex1fsX=x1fs0-ex1fsX;
        
    fprintf('Terminando FuncionDeError\n\n');
return