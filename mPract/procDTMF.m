function procDTMF(Btn)
    Fm=8000;
    Ttm=3.0;
    A=1;
    D=0;

    [FsBaja,FsAlta]=funDTMF(Btn);
    
    vxtm=geVcxTiem(Ttm,Fm);
    
    fsmmB=funSe(A,FsBaja,D,vxtm);
        
    fsmmA=funSe(A,FsAlta,D,vxtm);
    
    fsmmAB=fsmmB+fsmmA;
    
    magDFTB=absFFT(fsmmB);
    
    magDFTA=absFFT(fsmmA);
    
    magDFTAB=absFFT(fsmmAB);
    
    vxfa=geVcxFreFun(magDFTA,Fm);
    
    m=round(length(vxtm)/400);
    mAux2=round(length(vxfa)/2);
    
    subplot(2,1,1)
    plot(vxtm(1:m),fsmmA(1:m))
    title('Tono Alto');
    ylabel('Magnitud');
    xlabel('Tiempo');
    
    subplot(2,1,2)
    stem(vxfa(1:mAux2),magDFTA(1:mAux2))
    title('Magnitud DFT');
    ylabel('Magnitud');
    xlabel('Frecuencia');
    
    figure
    
    subplot(2,1,1)
    plot(vxtm(1:m),fsmmB(1:m))
    title('Tono Bajo');
    ylabel('Magnitud');
    xlabel('Tiempo');
    
    subplot(2,1,2)
    stem(vxfa(1:mAux2),magDFTB(1:mAux2))
    title('Magnitud DFT');
    ylabel('Magnitud');
    xlabel('Frecuencia');
    
    figure
    
    subplot(2,1,1)
    plot(vxtm(1:m),fsmmAB(1:m))
    title('Tonos combinados');
    ylabel('Magnitud');
    xlabel('Tiempo');
    
    subplot(2,1,2)
    stem(vxfa(1:mAux2),magDFTAB(1:mAux2))
    title('Magnitud DFT');
    ylabel('Magnitud');
    xlabel('Frecuencia');
    
    sound(fsmmA,Fm)
    
    pause(4);
    
    sound(fsmmB,Fm)
    
    pause(4);
    
    sound(fsmmAB,Fm)
    
    pause(4);
    
return;