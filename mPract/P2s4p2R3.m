function P2s4p2R3() 
    [G1, F1]=audioread('Grabacion1.wav');
    [G2, F2]=audioread('Grabacion2.wav');
    for k=1:2
        if k==1
           funVoz1=G1;
           Fm1=F1;
        else
           funVoz1=G2;
           Fm1=F2;
        end
        
        FmRefe=16000;
        FmSub=[8000,4000,2000,1000,500];
        vxtm1=geVcxTiemFun(funVoz1, Fm1);

        sound(funVoz1,FmRefe);    % Reproduccion sonora

        [magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,funVoz1);    % Generacion de las magnitudes del espectro de frecuencia 
        fprintf('Espectro: [FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FmRefe, size(magDFTRefe));

        figure(1);
        txtTitle=sprintf('FmRefe=%.2f Hz', FmRefe);
        vista=100;    % Subtotal de puntos a graficar
        funGraOnda(funVoz1,vxtm1,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal
        funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);    % Grafica las magnitudes de frecuencia de la señal
        fprintf('Terminando P3As4p1R1\n\n');

        for i=1:length(FmSub)
            pause(4)
            [fsmmSub,vxtmSub]= funSubMues(funVoz1,FmRefe,FmSub(i));
            try
                sound(fsmmSub,FmSub(i));
            catch
                warning('Frecuencia de submuestreo inválida');
            end
            [magDFTRefe,vxfaRefe]=funGeMagFre(FmSub(i),fsmmSub);    % Generacion de las magnitudes del espectro de frecuencia 

            figure
            txtTitle=sprintf('FmRefe=%.2f Hz', FmSub(i));
            funGraOnda(fsmmSub,vxtmSub,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal
            funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);    % Grafica las magnitudes de frecuencia de la señal

            fprintf('Señal submuestreada a %.2f Hz\n',FmSub(i))
            fprintf('\n')

            [pex1fsX, px1fs0, snrxlfsXdb] = funSNR(funVoz1,fsmmSub,FmRefe,FmSub(i));
        end

        pause(4)

    end

return;