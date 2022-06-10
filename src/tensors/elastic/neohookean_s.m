function sigma = neohookean_s(k, x, X, z, Mat)
	Fd = deformF(x(:,:,k), X, z);
    J = det(Fd);
    b = bStrain(Fd);
    sigma = Mat.mu*(b-eye(size(b)))/J+Mat.lambda*log(J)*eye(size(b))/J;
end