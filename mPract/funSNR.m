function [pex1fsX, px1fs0, snrx1fsXdb] = funSNR(x1fs0,x1fsX,Fm,FmSub)

ex1fsX=SenalError(x1fs0,x1fsX,Fm,FmSub); 

pex1fsX=funPoMe(ex1fsX);
fprintf('La potencia promedio de la señal residual es = %s miliWatts\n',pex1fsX)
fprintf('\n')

px1fs0=funPoMe(x1fs0); 
fprintf('La potencia promedio de la señal original es = %.8f miliWatts\n',px1fs0)
fprintf('\n')

snrx1fsX=(px1fs0/pex1fsX);
fprintf('La relación señal ruido es = %.8f \n',snrx1fsX)
fprintf('\n')

snrx1fsXdb=10*log10(snrx1fsX); 
fprintf('La relación señal ruido en decibeles es = %.8f \n',snrx1fsXdb)
fprintf('\n')

return;


