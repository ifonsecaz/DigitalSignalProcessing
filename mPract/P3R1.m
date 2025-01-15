A=5;  % Amplitud maxima de la onda
FRefe=2;  % Frecuencia de la onda señal (Hz)
D=0;  % Defasamiento

N=8;
L=2^N;
Q=2*A/L;

FmRefe=20;  % Frecuencia de muestreo (Hz)
Ttm=1; % Tiempo total de muestreo (segs)

[PAMS,vxtmRefe]=funGeSe(FmRefe,Ttm,A,FRefe,D);    % Generacion de señal senoidal
fprintf('Senoidal: [FRefe=%.2f, FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FRefe, FmRefe, size(PAMS));

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PAMS);    % Generacion de las magnitudes del espectro de frecuencia 
fprintf('Espectro: [FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FmRefe, size(magDFTRefe));

figure;
txtTitle=sprintf('Senoidal: FRefe=%.2f, FmRefe=%.2f Hz', FRefe, FmRefe);
vista=100;    % Subtotal de puntos a graficar
funGraOnda(PAMS,vxtmRefe,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal
funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);    % Grafica las magnitudes de frecuencia de la señal


figure;
subplot(2,1,1);
stem(vxtmRefe,PAMS);
title('Senoidal: FRefe=2.00, FmRefe=10.00 Hz');
ylabel('Magnitud')
xlabel('tiempo')
funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);

PAMSO=PAMS+A; %Offset

PMSOF=PAMSO*L/(2*A); %Cuantización fraccional

PMSOC=round(PMSOF);

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PMSOC);

figure;
subplot(2,1,1);
stem(vxtmRefe,PMSOC);
title('Cuantización: L=16');
ylabel('Magnitud')
xlabel('tiempo')
funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);

PAMSOC=PMSOC*(2*A)/L-A;

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PAMSOC);

figure;
subplot(2,1,1);
stem(vxtmRefe,PAMSOC);
title('Señal cuatizada');
ylabel('Magnitud')
xlabel('tiempo')
funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);

[pex1fsX, px1fs0, snrxlfsXdb, error] = funSNR(PAMS,PAMSOC,FmRefe,FmRefe);

figure;
stem(vxtmRefe,error);
title('Señal error cuantizada');
ylabel('Magnitud')
xlabel('tiempo')

tren=dec2bin(PMSOC);

[a b]=size(tren);

bits=zeros(0);
for i=1:10
    bits=[bits tren(i,:)];
end

figure;
stairs(bits-'0')
title('Tren de pulsos');
ylim([-0.2 1.2])
ylabel('Niveles')
xlabel('tiempo')


PCMSOCD=transpose(bin2dec(tren));
PCMSOCD=PCMSOCD*(2*A)/L;
PAMSD=PCMSOCD-A;

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PAMSD);

figure;
subplot(3,1,1);
stem(vxtmRefe,PAMSD);
title('Señal Decodificada');
ylabel('Magnitud')
xlabel('tiempo')
subplot(3,1,2);
plot(vxtmRefe,PAMSD);
ylabel('Magnitud');
xlabel('tiempo')
funGraMagFre(magDFTRefe,vxfaRefe,[3,1,3]);

%{
[pex1fsX, px1fs0, snrxlfsXdb, error] = funSNR(PAMS,PAMSD,FmRefe,FmRefe);

figure;
stem(vxtmRefe,error);
title('Señal error reconstruida');
ylabel('Magnitud')
xlabel('tiempo')
%}
