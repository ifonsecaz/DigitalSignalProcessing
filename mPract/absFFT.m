function magDFT=absFFT(fsmm)
    % absFFT: Calcula el vector magnitud de la DFT a partir de
    % fsmm : Vector función magnitud de señal

    % magDFT: Vector magnitud de la DFT (Discrete Fourier T.)

    funDFT = fft(fsmm);   % Calculo de la DFT
    magDFT = abs(funDFT);    % Magnitud de la DFT

    fprintf('Saliendo de absFFT\n\n');
return;
