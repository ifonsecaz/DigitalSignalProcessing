function magDFT=absFFT(fsmm)
% absFFT: Calcula la magnitud de la DFT a partir de
% fsmm : Funcion a operar

% magDFT: Magnitud de la DFT (Discrete Fourier T.)

funDFT = fft(fsmm);   % Calculo de la DFT
magDFT = abs(funDFT);    % Magnitud de la DFT

fprintf('Saliendo de absFFT\n\n');
return;