function sigma = venant_s(k, x, X, z, Mat)
	Fd   = deformF(x(:,:,k), X, z);
    J    = det(Fd);
    E    = EStrain(Fd); % OK
    
    S    = Mat.lambda*trace(E)*eye(size(E)) + 2*Mat.mu*E;
    sigma = Fd*S*Fd'/J;
end