function c = fmaxwell_c(k, xe_t, X, z, Mat, Set)
	ea = Mat.c(1); a = Mat.cexp(1);
	eb = Mat.c(2); b  = Mat.cexp(2);	
	tau = ea/eb;
	fact = tau*Set.dt^(a-b)/(Set.dt^(a-b)+tau);
    ce = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	c = ce*fact/Set.dt^a;
end