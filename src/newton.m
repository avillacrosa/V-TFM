%--------------------------------------------------------------------------
% Newton-Raphson solver for nonlinear elasticity
%--------------------------------------------------------------------------
function [u_t, stress, Q_t] = newton(k, u_t, Q_t, incr, R, F, Geo, Mat, Set)
	dof = vec_nvec(Geo.dof);
    tol = norm(R(Geo.dof))/Geo.x_units;

    it  = 1;
    X = vec_nvec(Geo.X);
	while(tol > Set.newton_tol)
		
		% this is whats fucked up, x(:,k) is set back to 0 which is not
		% correct I think?
		if strcmpi(Mat.elast, 'hookean'), x = X + zeros(size(u_t)); else, x = X + u_t; end


		K_c							  = constK(k, x, Q_t, Geo, Mat, Set);        
		[K_s, stress, Q_t(:,:,:,:,k+Set.dk)] = stressK(k, x, Q_t, Geo, Mat, Set); 
		
		K   = K_c + K_s;
		du = K(dof, dof)\(-R(dof));
		u_t(dof,k+Set.dk) = u_t(dof,k+Set.dk) + du;
		x = X + u_t;
		T = internalF(k, x, Q_t, Geo, Mat, Set);
		R = T - F;
		tol = norm(R(dof))/Geo.x_units;
		fprintf('INCR = %i, ITER = %i, tolR = %e, tolX = %e\n',...
         		incr,it,tol,norm(du)/Geo.x_units);
		it = it + 1;
	end
    fprintf("> INCR %i CONVERGED IN %i ITERATIONS \n", incr, it-1);
end
