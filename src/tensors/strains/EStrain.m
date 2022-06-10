function E = EStrain(Fd)
    E = 0.5*(CStrain(Fd)-eye(size(Fd)));
end