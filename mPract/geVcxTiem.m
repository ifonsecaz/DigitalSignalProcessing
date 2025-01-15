function vxtm=geVcxTiem(Ttm,Fm)
    %geVcxTiem: Generacion de un vector de coordenadas X de tiempo a partir de
    % Ttm : Tiempo total de muestreo base (seg)
    % Fm : Frecuencia de muestreo base (Hz)

    % vxtm: Vector coordenadas X con los tiempos de muestreo. Escala.


    Tm=1/Fm;  % Periodo del muestreo base (seg)
    N=fix(Ttm/Tm);  % Total de puntos a muestrear
    vpm=0:N-1;  % Vector con los puntos de muestreo

    vxtm=vpm*Tm;

    fprintf('Saliendo de geVcxTiem\n\n');
return;
