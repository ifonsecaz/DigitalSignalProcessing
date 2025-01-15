function vxfa=geVcxFreFun(magDFT,Fm)
    % geVcxFreFun: Genera un vector de coordenadas X a partir de
    % magDFT: Vector magnitud de la DFT
    % Fm: Frecuencia de muestreo (Hz)

    % vxfa: vector de coordenadas X correspondientes a las armónicas. Escala.

    Tm=1/Fm;  % Periodo del muestreo base (seg)
    N=length(magDFT);  % Total de puntos de frecuencias
    vp=0:N-1;  % Vector de puntos
    FAmin=1/(N*Tm);  % Armonica mas pequeña
    vxfa=vp*FAmin;  % Coordenadas de las Armonicas

    fprintf('Saliendo de geVcxFreFun\n\n');
return;
