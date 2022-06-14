function c = maxwell_c(k, xe_t, X, Qe_t, z, Mat, Set)
    c = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	tau = Mat.visco/Mat.E;
	xi = -Set.dt/(2*tau);
	c = c*(exp(xi));
end