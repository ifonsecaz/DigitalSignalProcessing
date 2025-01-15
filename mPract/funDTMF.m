function [FBaja,FAlta]=funDTMF(Btn)
    % Esta funcion entrega las dos frecuencias correspondientes al boton Btn.
    % Btn: Boton del 0 al 15 segun la tabla de DTMF.

    % FBaja: Frecuencia Baja
    % FAlta: Frecuencia Alta

    if Btn<0 || Btn>15
        fprintf('ERROR(funDTMF): boton inexistente entre [0-15]= %7.0f\n', Btn);
        FBaja=-1;    FAlta=-1;
        return
    end

    %Frecuencias bajas del DTMF (Hz)
    f1=697; f2=770; f3=852; f4=941;
    fb=[f4,f1,f1,f1,f2,f2,f2,f3,f3,f3,f4,f4,f1,f2,f3,f4];

    %Frecuencias altas del DTMF (Hz)
    f5=1209; f6=1336; f7=1477; f8=1633; 
    fa=[f6,f5,f6,f7,f5,f6,f7,f5,f6,f7,f5,f7,f8,f8,f8,f8];  

    FBaja=fb(Btn+1);
    FAlta=fa(Btn+1);

    fprintf('Combinacion de frecuencias= %12.0f\n', Btn);
    fprintf('Frecuencia baja= %15.2f Hz\n', FBaja);
    fprintf('Frecuencia alta= %15.2f Hz\n', FAlta);

    fprintf('Saliendo de funDTMF\n\n');
return; 
