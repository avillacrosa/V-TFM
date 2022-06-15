%--------------------------------------------------------------------------
% Newton-Raphson solver for nonlinear elasticity
%--------------------------------------------------------------------------
function [u_t, s_t, Int] = newton(k, u_t, s_t, R, F_t, Geo, Mat, Set, Int)
	dof = vec_nvec(Geo.dof);
    tol = norm(R(dof))/Geo.x_units;

    it  = 1;
    X   = vec_nvec(Geo.X);
	x_t = X + u_t;
	while(tol > Set.newton_tol)
		[K_c, Int]	= constK(k, x_t, Geo, Mat, Set, Int);        
		K_s			= stressK(k, x_t, s_t, Geo, Mat, Set, Int); 
		K   = K_c + K_s;

		du = K(dof, dof)\(-R(dof));
		x_t(dof,k+Set.dk) = x_t(dof,k+Set.dk) + du;

		[T, s_t, Int] = internalF(k, x_t, s_t, Geo, Mat, Set, Int);
		R = T - F_t(:,k+Set.dk);
		tol = norm(R(dof))/Geo.x_units;
		fprintf('ITER = %i, tolR = %e, tolX = %e\n', it,tol,norm(du)/Geo.x_units);
		it = it + 1;
	end
	u_t = x_t - X;
end
