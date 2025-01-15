function pm=funPoMe(funVoz)
    
    [a,b]=size(funVoz);
    
    if a==1
        pm=(funVoz*transpose(funVoz))/length(funVoz);
    else
        pm=(transpose(funVoz)*funVoz)/length(funVoz);
    end
    %fprintf('Saliendo de funPoMe\n\n');
    
return;