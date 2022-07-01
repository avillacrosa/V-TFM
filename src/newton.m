%--------------------------------------------------------------------------
% Newton-Raphson solver for nonlinear elasticity
%--------------------------------------------------------------------------
function [x_t, s_t, Geo, Int] = newton(k, x_t, s_t, R, F_t, Geo, Mat, Set, Int)
	dof = vec_nvec(Geo.dof);
    tol = norm(R(dof))/Geo.x_units;
	[Q, x_t]	= updateDirichlet(k, x_t, Geo, Mat, Set);

    it  = 1;
	while(tol > Set.newton_tol)
		K_c	= constK(k, x_t, Geo, Mat, Set);        
		K_s	= stressK(k, x_t, s_t, Geo, Mat, Set, Int); 
		K   = K_c + K_s;

        K = K*Q; 

		du = K(dof, dof)\(-R(dof));
		x_t(dof,k+Set.dk) = x_t(dof,k+Set.dk) + du;

		[Q, x_t]	= updateDirichlet(k, x_t, Geo, Mat, Set);

		[T, s_t, Int] = internalF(k, x_t, s_t, Geo, Mat, Set, Int);
		R = T - F_t(:,k+Set.dk);

		tol = norm(R(dof))/Geo.x_units;
		
		fprintf('ITER = %i, tolR = %e, tolX = %e\n', it,tol,norm(du)/Geo.x_units);
		it = it + 1;
	end
end

% 		x_v = ref_nvec(x_t(:,k), Geo.n_nodes, Geo.dim);
% 		x_v(Geo.fixR(:,:,k))
		
