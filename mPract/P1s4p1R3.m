function P1s4p1R3()
    [funVoz,Fm]=audioread('G_01.wav');
    funVoz=funVoz(:,1);
    
    fprintf('Se�al de audio 1\n');
    
    whos
    
    [pm]=funPoMe(funVoz);
    fprintf('La potencia promedio de la se�al es = %s Watts\n',pm)
    fprintf('\n')
    
    [funVoz,Fm]=audioread('G_02.wav');
    funVoz=funVoz(:,1);
    
    fprintf('Se�al de audio 2\n');
    
    whos
    
    [pm]=funPoMe(funVoz);
    
    fprintf('La potencia promedio de la se�al es = %s Watts\n',pm)
    fprintf('\n')
    
    [funVoz,Fm]=audioread('G_03.wav');
    funVoz=funVoz(:,1);

    fprintf('Se�al de audio 3\n');
    
    whos
    
    [pm]=funPoMe(funVoz);
    
    fprintf('La potencia promedio de la se�al es = %s Watts\n',pm)
    fprintf('\n')
    
return;