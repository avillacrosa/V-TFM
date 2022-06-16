function c = gmaxwell_c(k, xe_t, X, z, Mat, Set)
    c = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	tau = Mat.c(2)/Mat.c(1);
	% FORWARD
% 	fact = (1-Set.dt/tau);
	% BACKWARD
	fact = ((tau/(tau+Set.dt)));
	c = c*(1+fact);
end