%Detecci�n de formantes
%Telescope

%Se crea un objeto audiorecorder, sus par�metros son la frecuencia de
%muestreo=44100, bits por muestra=16, n�mero de canales=1
RecObj=audiorecorder(44100,16,1);
%Se tomo FS=44100 la cual es la frecuencia de muestreo normal para la voz

disp('Comienza a grabar')
%Graba un clip de audio y lo guarda en el objeto creado, 3 corresponde a los segundos de la grabaci�n
recordblocking(RecObj,3);
disp('Termin� la grabaci�n')

%Genera un vector con el audio
y=getaudiodata(RecObj);

%Calcula la transformada r�pida de Fourier, con una resoluci�n de 16 bits
y=fft(y,65536);

%Genero otro vector de puntos para graficar, ajustado a la frecuencia de
%muestreo
f=linspace(0,65535,65536)*(44100/65536);

%Grafico la fft, se usa 10log10 para pasar a decibeles, y se toma abs para
%graficar solo la magnitud
plot(f,10*log10(abs(y)))

hold on

grid on

%Para eliminar anormalidades y suavizar la se�al, se calcula un promedio m�vil con 800 muestras
plot(f,10*log10(movmean(abs(y),800)))