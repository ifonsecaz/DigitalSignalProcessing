% 4.1
% Paso 1
FmRefe = 400; %Frecuencia de muestreo (Hz)
Ttm = 2; %Tiempo total de muestreo (segs)
A = 1; %Amplitud maxima de la onda
FRefe = 2; %Frecuencia de la señal (Hz)
D = 0;
N = 8;
L = 2^N;

[fsmmRefe,vxtmRefe]=funGeSe(FmRefe,Ttm,A,FRefe,D);    % Generacion de señal senoidal
fprintf('Senoidal: [FRefe=%.2f s, FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FRefe, FmRefe, size(fsmmRefe));


% Paso 2
mu = 255;
s = 4*sin(2*pi*FRefe*vxtmRefe)+3*cos(3*pi*FRefe*vxtmRefe)+2*sin(4*pi*FRefe*vxtmRefe)+1*cos(5*pi*FRefe*vxtmRefe);

figure(1);
txtTitle=sprintf('s(t): Senoidal con FRefe=%.2f, FmRefe=%.2f Hz', FRefe, FmRefe);
vista=800;    % Subtotal de puntos a graficar
funGraOnda(s,vxtmRefe,txtTitle,vista,[1,1,1]);    % Grafica la onda de la señal

Amp=max(abs(s));
z=s/Amp;

figure(2)
txtTitle=sprintf('Senoidal normalizada z(t)');
funGraOnda(z,vxtmRefe,txtTitle,vista,[2,1,1]);

F = sign(z).*(log(1+(mu*abs(z)))/log(1+mu));
subplot(2,1,2)
plot(z,F)
title('Funcionalidad de compresor F(z)')

% Paso 3 (Resultado de la práctica 3)
A = max(abs(F));
PAMSO=F+A; %Offset

PMSOF=PAMSO*L/(2*A); %Cuantización fraccional

PMSOC=round(PMSOF);

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PMSOC);

PAMSOC=PMSOC*(2*A)/L-A;

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PAMSOC);

[pex1fsX, px1fs0, snrxlfsXdb, error] = funcSNR(s,PAMSOC,FmRefe,FmRefe);

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
subplot(2,1,1);
plot(vxtmRefe,PAMSD);
ylabel('Magnitud');
xlabel('tiempo')
funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);

% Paso 4
Finv=sign(PAMSD).*(1/mu).*((1+mu).^(abs(PAMSD)) - 1);

figure(3)
subplot(2,1,1)
plot(vxtmRefe,PAMSD)
title('Funcionalidad de compresor w = F(z)')

subplot(2,1,2)
plot(vxtmRefe,Finv)
title('Funcionalidad del expansor F-1(w)')

figure(4)
FmRefe = 400; %Frecuencia de muestreo (Hz)
Ttm = 2; %Tiempo total de muestreo (segs)
A = 1; %Amplitud maxima de la onda
FRefe = 2; %Frecuencia de la señal (Hz)
D = 0;
%[fsmmRefe,vxtmRefe]=funGeSe(FmRefe,Ttm,A,FRefe,D);    % Generacion de señal senoidal
fprintf('Senoidal: [FRefe=%.2f s, FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FRefe, FmRefe, size(fsmmRefe));
txtTitle=sprintf('Voice in');
vista=800;    % Subtotal de puntos a graficar
funGraOnda(s,vxtmRefe,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal

subplot(2,1,2)
plot(vxtmRefe,Finv*Amp)
title('Voice out')
