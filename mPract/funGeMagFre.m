function [magDFT,vxfa]=funGeMagFre(Fm,fsmm)
% Genera una funcion de las magnitudes del espectro de frecuencias de una funcion 
% dada y su vector de armonicas (eje x).

% Fm: Frecuencia de muestreo (Hz)
% fsmm: vector de valores de una onda señal
    
magDFT=absFFT(fsmm);    % Vector de magnitudes del espectro de frecuencias
vxfa=geVcxFreFun(magDFT,Fm);    % Calcula vector de armonicas a partir del vector magnitud (eje x)

fprintf('Terminando funGeMagFre\n\n');
return;