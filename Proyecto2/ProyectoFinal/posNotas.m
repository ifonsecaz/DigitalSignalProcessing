function [Posiciones] = posNotas()
Posiciones(10)=42.667;
Posiciones(11)=39.8;
Posiciones(12)=35.5;
Posiciones(13)=33.5;
Posiciones(14)=29;
Posiciones(15)=23.5;
Posiciones(16)=22;
Posiciones(17)=19.75;
[~, ~, val]=find(Posiciones);
PosicionesTemp=val(2:end);
mediaNotas=mean(val(1:end-1)-PosicionesTemp);
Posiciones(1)=Posiciones(10)+mediaNotas*9;
for i=2:9
    Posiciones(i)=Posiciones(i-1)-mediaNotas;
end
Posiciones(18)=Posiciones(end)+mediaNotas;
Posiciones(19)=0;

end

