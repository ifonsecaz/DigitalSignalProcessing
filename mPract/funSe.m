function fsmm=funSe(A,F,D,vxtm)
    % funSe: Genera un vector funcion senoidal a partir de
    % A : Amplitud maxima (v)
    % F : Frecuencia de la onda (Hz)
    % D : Defasamiento  (grados-radianes)
    % vxtm : Vector con los X tiempos de muestreo (seg). Escala.

    % fsmm : Vector funcion senoidal modulada y muestreada (vector)

    fsmm=A*sin(2*pi*F*vxtm);

    fprintf('Saliendo de funSe\n\n');
return;
