function dummy=P2As4p1R1()
% Realiza: Prac2 parte A - sec4.1 - Teorema del muestreo - Reporte 1

FmRefe=16000;  % Frecuencia de muestreo (Hz)
Ttm=2; % Tiempo total de muestreo (segs)

A=1;  % Amplitud maxima de la onda
FRefe=1000;  % Frecuencia de la onda señal (Hz)
D=0;  % Defasamiento

[fsmmRefe,vxtmRefe]=funGeSe(FmRefe,Ttm,A,FRefe,D);    % Generacion de señal senoidal
fprintf('Senoidal: [FRefe=%.2f, FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FRefe, FmRefe, size(fsmmRefe));

sound(fsmmRefe,FmRefe);    % Reproduccion sonora

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,fsmmRefe);    % Generacion de las magnitudes del espectro de frecuencia 
fprintf('Espectro: [FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FmRefe, size(magDFTRefe));

figure(1);
txtTitle=sprintf('Senoidal: FRefe=%.2f, FmRefe=%.2f Hz', FRefe, FmRefe);
vista=100;    % Subtotal de puntos a graficar
funGraOnda(fsmmRefe,vxtmRefe,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal
funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);    % Grafica las magnitudes de frecuencia de la señal
fprintf('Terminando P3As4p1R1\n\n');
return;