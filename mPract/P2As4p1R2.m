
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
pause(3)

% Submuestreo
FmSub = [8000,4000,2000,1000,500];
for i = 1:length(FmSub)
    [fsmmSub,vxtmSub]= funSubMues(fsmmRefe,FmRefe,FmSub(i));

    try
        sound(fsmmSub,FmSub(i));
    catch
        warning('Frecuencia de submuestreo inválida');
    end
    
    txtTitle=sprintf('Submuestreo: FmSub=%.2f Hz', FmSub(1,i));
    
    figure(i+1)
    funGraOnda(fsmmSub,vxtmSub,txtTitle,vista,[2,1,1]);
    
    [magDFTSub,vxfaSub]=funGeMagFre(FmSub(1,i),fsmmSub);
    funGraMagFre(magDFTSub,vxfaSub,[2,1,2]);
    % scatter(vxtmSub, fsmmSub)

    pause(3)

    % Potencia Media y SNR
    [pex1fsX, px1fs0, snrxlfsXdb] = funSNR(fsmmRefe,fsmmSub,FmRefe,FmSub(1,i));
end
