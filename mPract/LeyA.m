A=255;

Amp=4;
FRefe=2;  % Frecuencia de la onda señal (Hz)
D=0;  % Defasamiento

N=8;

FmRefe=400;  % Frecuencia de muestreo (Hz)
Ttm=2; % Tiempo total de muestreo (segs)

[PAMS,vxtmRefe]=funGeSe(FmRefe,Ttm,Amp,FRefe,D);    % Generacion del vector t

PAMS=4*sin(2*pi*FRefe*vxtmRefe)+3*cos(3*pi*FRefe*vxtmRefe)+2*sin(4*pi*FRefe*vxtmRefe)+1*cos(5*pi*FRefe*vxtmRefe);

Amp=max(abs(PAMS)); %Amplitud máxima de la onda

%Normalización
z=PAMS/Amp+1/A; %Se suma o resta 1/A para que no se indetermine con valores pequeños

fprintf('Senoidal: [FRefe=%.2f, FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FRefe, FmRefe, size(PAMS));

figure;
txtTitle=sprintf('Señal: FRefe=%.2f, FmRefe=%.2f Hz', FRefe, FmRefe);
vista=800;    % Subtotal de puntos a graficar
funGraOnda(PAMS,vxtmRefe,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal
txtTitle=sprintf('Señal normalizada z');
funGraOnda(z,vxtmRefe,txtTitle,vista,[2,1,2]);    % Grafica las magnitudes de frecuencia de la señal


%Compresión
syms Fexp zexp;
Fexp=sign(zexp).*((1+log(A*abs(zexp)))/(1+log(A)));
figure
subplot(2,1,1)
fplot(Fexp)

F=sign(z).*((1+log(A*abs(z)))/(1+log(A)));

Amp1=max(abs(z)); %Amplitud máxima de la onda
L=2^N;
Q=2*Amp1/L;

subplot(2,1,2)
plot(vxtmRefe,F);
title('Señal comprimida F')


PAMSO=F+Amp1; %Offset

PMSOF=PAMSO*L/(2*Amp1); %Cuantización fraccional

PMSOC=round(PMSOF);

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PMSOC);

PAMSOC=PMSOC*(2*Amp)/L-Amp1;

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PAMSOC);

[pex1fsX, px1fs0, snrxlfsXdb, error] = funcSNR(PAMS,PAMSOC,FmRefe,FmRefe);

tren=dec2bin(PMSOC);

[a b]=size(tren);

bits=zeros(0);
for i=1:FmRefe
    bits=[bits tren(i,:)];
end

aux=bits(1:50);

figure;
stairs(aux-'0')
title('Tren de pulsos');
ylim([-0.2 1.2])
ylabel('Niveles')
xlabel('tiempo')


PCMSOCD=transpose(bin2dec(tren));
PCMSOCD=PCMSOCD*(2*Amp1)/L;
PAMSD=PCMSOCD-Amp1;

[magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,PAMSD);

%Expansor
Fexp=sign(zexp).*(exp(abs(zexp)*(1+log(A))-1)/A);
figure
subplot(2,1,1)
fplot(Fexp)

Fw=sign(PAMSD).*(exp(abs(PAMSD)*(1+log(A))-1)/A);

subplot(2,1,2);
funGraOnda(Fw,vxtmRefe,txtTitle,vista,[2,1,2]);

sout=Fw*Amp;

figure
subplot(2,1,1)
txtTitle=('S(in)');
funGraOnda(PAMS,vxtmRefe,txtTitle,vista,[2,1,1]);
subplot(2,1,2)
txtTitle=('S(out)');
funGraOnda(sout,vxtmRefe,txtTitle,vista,[2,1,2]);
