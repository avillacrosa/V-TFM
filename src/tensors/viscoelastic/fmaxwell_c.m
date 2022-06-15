function [c, Int] = fmaxwell_c(k, e, gp, xe_t, X, z, Mat, Set, Int)
	ea = Mat.c(1); a = Mat.cexp(1);
	eb = Mat.c(2); b  = Mat.cexp(2);	
	tau = ea/eb;
	fact = tau/(1+tau*Set.dt^(b-a));
    ce = ctensor_elast(xe_t(:,:,k+1), X, z, Mat);
	Int.ce_t(:,:,:,:,e,gp,k+1) = ce;
	c = ce + glderiv(Int.ce_t(:,:,:,:,e,gp,:), k+1, Set.dt, Mat.cexp(1), 1)*fact;
end