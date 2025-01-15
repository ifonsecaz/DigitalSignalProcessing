[y,fs]=audioread('sample_1.wav');
y=y(:,1);
plot(y)
figure
yT=fft(y,65536);
yT=yT(1:length(yT)/2);
[M,I]=max(abs(yT));
f=linspace(0,65535,65536)*(44100/65536);
f=f(1:length(f)/2);
plot(f,(abs(yT)))

posW=(I)*44100/65536; %Calcula la frecuencia
cutOff1=((posW-40)*2)/fs; %La normaliza
cutOff2=((posW+40)*2)/fs;

b=fir1(2000,[cutOff1,cutOff2],'stop');
yf=conv(y,b);
figure
yT=fft(yf,65536);
yT=yT(1:length(yT)/2);
plot(f,(abs(yT)))

pause(1);
%sound(y,fs)

pause(4);
%sound(yf,fs)

figure

[y,fs]=audioread('sample_2.wav');
y=y(:,1);
plot(y)
figure
yT=fft(y,65536);
yT=yT(1:length(yT)/2);
[M,I]=max(abs(yT));
f=linspace(0,65535,65536)*(44100/65536);
f=f(1:length(f)/2);
plot(f,(abs(yT)))

posW=(I)*44100/65536; %Calcula la frecuencia
i=1;

while (i*posW)<(fs/2)
    cutOff1=(((posW*i)-35)*2)/fs; %La normaliza
    cutOff2=(((posW*i)+35)*2)/fs;

    b=fir1(2000,[cutOff1,cutOff2],'stop');
    
    if i>1
        filtro=conv(filtro,b);
    else
        filtro=b;
    end
    
    i=i+1;
end

yf=conv(y,filtro);

figure
yT=fft(yf,65536);
yT=yT(1:length(yT)/2);
plot(f,(abs(yT)))

pause(1);
%sound(y,fs)

pause(4);
%sound(yf,fs)

figure

[y,fs]=audioread('sample_3.wav');
y=y(:,1);
plot(y)
figure
yT=fft(y,65536);
yT=yT(1:length(yT)/2);
[M,I]=max(abs(yT));
f=linspace(0,65535,65536)*(44100/65536);
f=f(1:length(f)/2);
plot(f,(abs(yT)))

figure

%findpeaks(y,'MinPeakHeight',3500);

posW=3720; %Calcula la frecuencia
cutOff1=((posW)*2)/fs; %La normaliza


b=fir1(2000,cutOff1);

yf=conv(y,b);

yT=fft(yf,65536);
yT=yT(1:length(yT)/2);
plot(f,(abs(yT)))

pause(1);
sound(y,fs)

pause(4);
sound(yf,fs)