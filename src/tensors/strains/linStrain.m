function eps = linStrain(Fd)
     eps = (Fd'+Fd)/2-eye(size(Fd));
end