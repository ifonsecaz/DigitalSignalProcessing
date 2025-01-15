function [fsmmSub,vxtmSub]= funSubMues(fsmm,Fm,FmSub)
% Genera una nueva onda señal con una frecuencia de submuestreo.
% fsmm - onda señal a submuestrear
% fsmmSub - onda señal bajo la nueva frecuencia de muestreo FmN
% Fm - frecuencia de muestreo de fsmm
% FmSub - nueva frecuencia de muestreo (frecuencia de submuestreo)

% tsSub=fix(Fm/FmSub);    % tasa de submuestreo
tsSub=Fm/FmSub;    % tasa de submuestreo
Nfsmm=length(fsmm);
NfssmSub=fix(Nfsmm/tsSub);

TmSub=1/FmSub;
pSub=0:NfssmSub-1;  % Vector con los puntos de submuestreo
vxtmSub=pSub*TmSub;  % Vector con los momentos de muestreo

fsmmSub=zeros(1,NfssmSub);  % ceros, vector horizontal

% Transferencia: vxtmSub(1)=fsmm(1);  vxtmSub(2)=fsmm(1+tsSub);  vxtmSub(2)=fsmm(1+tsSub*2); . . .  
fsmmSub=fsmm(1:tsSub:Nfsmm);

fprintf('Terminando funSubMues\n\n');
return;