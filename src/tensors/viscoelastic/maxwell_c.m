function c = maxwell_c(k, xe_t, X, Qe_t, z, Mat, Set)

    c = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	tau = Mat.visco/Mat.E;
	xi = -Set.dt/(2*tau);
	if Mat.Einf ~= 0
		c = c*(1+exp(xi));
	else
		c = c*(exp(xi));
	end
end