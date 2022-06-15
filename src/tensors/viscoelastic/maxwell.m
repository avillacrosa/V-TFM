function [c, Int] = maxwell_c(k, e, gp, xe_t, X, z, Mat, Set, Int)
    ce = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	tau = Mat.c(2)/Mat.c(1);
	xi = -Set.dt/(2*tau);
	c = ce*(exp(xi));
	Int.ce(:,:,:,:,e,gp,k+1)=ce;
end