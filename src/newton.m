%--------------------------------------------------------------------------
% Newton-Raphson solver for nonlinear elasticity
%--------------------------------------------------------------------------
function [u_t, stress, Q_t] = newton(k, u_t, Q_t, R, F, Geo, Mat, Set)
	dof = vec_nvec(Geo.dof);
    tol = norm(R(dof))/Geo.x_units;

    it  = 1;
    X   = vec_nvec(Geo.X);
	x_t = X + u_t;
	while(tol > Set.newton_tol)
		K_c	= constK(k, x_t, Q_t, Geo, Mat, Set);        
		K_s = stressK(k, x_t, Q_t, Geo, Mat, Set); 
		K   = K_c + K_s;

		du = K(dof, dof)\(-R(dof));
		x_t(dof,k+Set.dk) = x_t(dof,k+Set.dk) + du;

		[T, stress, Q_t] = internalF(k, x_t, Q_t, Geo, Mat, Set);
		R = T - F;
		tol = norm(R(dof))/Geo.x_units;
		fprintf('ITER = %i, tolR = %e, tolX = %e\n',...
         		it,tol,norm(du)/Geo.x_units);
		it = it + 1;
	end
	u_t = x_t - X;
	[~, ~, Q_t] = internalF(k, x_t, Q_t, Geo, Mat, Set);

    fprintf("> CONVERGED IN %i ITERATIONS \n", it-1);
end
