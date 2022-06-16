function c = maxwell_c(k, xe_t, X, z, Mat, Set)
    ce = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	tau = Mat.c(2)/Mat.c(1);
	% FORWARD
% 	fact = (1-Set.dt/tau);
	% BACKWARD
	fact = ((tau/(tau+Set.dt)));
	c = ce*fact;
end