function [c, Int] = gmaxwell_c(k, e, gp, xe_t, X, z, Mat, Set, Int)
    c = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	tau = Mat.c(2)/Mat.c(1);
	xi = -Set.dt/(2*tau);
	c = c*(1+exp(xi));
end