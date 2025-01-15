function SyS_P5_Starset1
%Parte 1 
%Creación de una señal periódica cuadrada
SyS_P5_Starset4(10,2);
title('N=10, N1=2')

%Parte 2
%Gráfica de señales cuadradas y sus coeficientes de Fourier
figure
SyS_P5_Starset5(10,2);
title('Coeficientes de Fourier, N=10, N1=2')     
figure
SyS_P5_Starset5(20,2);
title('Coeficientes de Fourier, N=20, N1=2') 
figure
SyS_P5_Starset5(40,2);
title('Coeficientes de Fourier, N=40, N1=2') 
figure
SyS_P5_Starset5(30,3);
title('Coeficientes de Fourier, N=30, N1=3') 
figure
SyS_P5_Starset5(30,6);
title('Coeficientes de Fourier, N=30, N1=6') 
figure
SyS_P5_Starset5(30,9);
title('Coeficientes de Fourier, N=30, N1=9') 
figure

%Parte 3
%Reconstrucción de la señal cuadrada
SyS_P5_Starset3(1);
title('N=9, N1=2, M=1') 
figure
SyS_P5_Starset3(2);
title('N=9, N1=2, M=2') 
figure
SyS_P5_Starset3(3);
title('N=9, N1=2, M=3') 
figure
SyS_P5_Starset3(4);
title('N=9, N1=2, M=4') 