function P1s4p1R2() 
    [funVoz1, Fm1]=audioread('G_01.wav');
    vxtm1=geVcxTiemFun(funVoz1, Fm1);
    magDFT1=absFFT(funVoz1);
    vxfa1=geVcxFreFun(magDFT1,Fm1);

    [funVoz2, Fm2]=audioread('G_02.wav');
    vxtm2=geVcxTiemFun(funVoz2, Fm2);
    magDFT2=absFFT(funVoz2);
    vxfa2=geVcxFreFun(magDFT2,Fm2);

    [funVoz3, Fm3]=audioread('G_03.wav');
    vxtm3=geVcxTiemFun(funVoz3, Fm3);
    magDFT3=absFFT(funVoz3);
    vxfa3=geVcxFreFun(magDFT3,Fm3);

    m1 = round(length(vxtm1)/10);
    m2 = round(length(vxtm2)/10);
    m3 = round(length(vxtm3)/10);

    subplot(2,3,1)
    plot(vxtm1(1:m1), funVoz1(1:m1))
    title('Grabación #1 (Voz normal)');
    ylabel('Magntiud');
    xlabel('Tiempo');

    subplot(2,3,2)
    plot(vxtm2(1:m2),funVoz2(1:m2))
    title('Grabación #2 (Tono grave)');
    ylabel('Magntiud');
    xlabel('Tiempo');

    subplot(2,3,3)
    plot(vxtm3(1:m3),funVoz3(1:m3))
    title('Grabación #3 (Tono agudo)');
    ylabel('Magntiud');
    xlabel('Tiempo');

    subplot(2,3,4)
    plot(vxfa1,magDFT1)
    ylabel('Magnitud');
    xlabel('Frecuencia (Hz)');
    xlim([0 4000]);

    subplot(2,3,5)
    plot(vxfa2,magDFT2)
    ylabel('Magnitud');
    xlabel('Frecuencia (Hz)');
    xlim([0 4000]);

    subplot(2,3,6)
    plot(vxfa3,magDFT3)
    ylabel('Magnitud');
    xlabel('Frecuencia (Hz)');
    xlim([0 4000]);

    sound(funVoz1,Fm1)
    pause(4)
    sound(funVoz2,Fm2)
    pause(4)
    sound(funVoz3,Fm3)

    whos
return;