%Espectrograma
%Telescope

[y,fs]=audioread('./HolaM.wav');

y=y(:,1);

plot(y)

figure

spectrogram(y,1024,0,1024,fs,'yaxis')

[s,w,t]=spectrogram(y,1024,0,1024,fs,'yaxis');

figure
f=s(:,51);
    
plot(w,10*log10(abs(f)))

hold on

grid on
    
plot(w,10*log10(movmean(abs(f),20)))
    
figure
f=s(:,66);
    
plot(w,10*log10(abs(f)))

hold on

grid on
    
plot(w,10*log10(movmean(abs(f),20)))
   
figure
f=s(:,89);
    
plot(w,10*log10(abs(f)))

hold on

grid on
    
plot(w,10*log10(movmean(abs(f),20)))
    
    figure
    f=s(:,102);
    
    plot(w,10*log10(abs(f)))

    hold on

    grid on
    
    plot(w,10*log10(movmean(abs(f),20)))
    
    
    
