function dummy=funGraMagFre(magDFT,vxfa,sbplt)
% Grafica una funcion de magnitudes de frecuencia.

% magDFT: Vector de magnitudes del espectro de frecuencias
% vxfa: Vector con armonicas (eje x)
% sbplt: definicion de ventana de subplot.

lon=length(magDFT);    % Total de valores del vector.

N=fix(lon/2);    % Porcion de frecuencias a desplegar

txtLegend=sprintf('Muestras: total=%.f / vista=%.f',lon,N);
fprintf('%s\n',txtLegend);

subplot(sbplt(1),sbplt(2),sbplt(3)),
    stem(vxfa(1:N),magDFT(1:N)),    title('Magnitudes de Frecuencias de la FFT'),
    xlabel('-->Frecuencia'),  ylabel('-->Magnitud'),    legend(txtLegend);

fprintf('Terminando funGraMagFre\n\n');
return;