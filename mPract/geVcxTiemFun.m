function vxtm=geVcxTiemFun(funVoz,Fm)
    %geVcxTiemFun: Generacion de un vector de coordenadas X de tiempo a partir de
    % funVoz: Vector señal de voz muestreada (vector)
    % Fm: Frecuencia de muestreo base (Hz)

    % vxtm: Vector con los momentos de tiempo de muestreo.Escala.

    Tm=1/Fm;  % Periodo del muestreo base (seg)
    N=length(funVoz);  % Total de puntos a muestrear
    vp=0:N-1;  % Vector con los puntos de muestreo
    vxtm=vp*Tm;

    fprintf('Saliendo de geVcxTiemFun\n\n');
return;
