function [c, Int] = maxwell_c_bf(k, e, gp, xe_t, X, z, Mat, Set, Int)
    ce = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	tau = Mat.c(2)/Mat.c(1);
	xi = -Set.dt/(2*tau);
	c = ce*((tau/(tau+Set.dt)));
	Int.ce(:,:,:,:,e,gp,k+1)=ce;
end