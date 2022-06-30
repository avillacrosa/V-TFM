function Result = solveTFM(Geo, Mat, Set, Result)
    M   = areaMassLISP(Geo.X, Geo, Set);
	X   = vec_nvec(Geo.X);
	x_t = X + vec_nvec(Geo.u);
    F_t = vec_nvec(Geo.F);
	s_t = zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);

	% Internal variables / history 
	Int.Q_t		= zeros(Geo.vect_dim, Mat.ve_elems, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);
	Int.se_t	= zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);
	Int.Se_t	= zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);

	t = 0;
	Geo.fixR = false(Geo.n_nodes, Geo.dim, Set.time_incr);
	for k = 1:Set.time_incr-Set.dk
		if Set.nano
			Set.r0(end) = Set.r0(end)+Set.v*Set.dt;
        	[~, Geo, Set] = updateDOFsQ(k, x_t, Geo, Mat, Set);
			x_t = updateDirichletQ(k, x_t, Geo, Mat, Set);
		end
        [T, ~, ~] = internalF(k, x_t, s_t, Geo, Mat, Set, Int);
    	R = T - F_t(:,k+Set.dk);
    	[x_t, s_t, Geo, Int] = newton(k, x_t, s_t, R, F_t, Geo, Mat, Set, Int);
% 		easyplot(k, x_t, Geo, Mat, Set);
% 		close all;
		if mod(k, Set.save_freq) == 0
			c = k/Set.save_freq + 1; % This goes to 1 more than k, is it good?
			Result = saveOutData(t, c, k, x_t, s_t, F_t, T, M, Geo, Mat, Set, Result);
			writeOut(c,Geo,Set,Result);
			
			fprintf("it = %4i, t = %.2f, |u| = ( ", k, t);
			fprintf("%.2f ", vecnorm(Result.x(:,:,c)-Geo.X, 2, 1));
			fprintf("), |stress| = ( ")
			fprintf("%.2f ", vecnorm(Result.s(:,:,c), 2, 2));
			fprintf(") \n")
		end
        t = t + Set.dt;
		if (Set.r0(end)-Set.r) <= (max(Geo.X(:,end))-Set.h)
			Set.v = -Set.v;
			Geo.fixR(:,:,(k+1):(2*k-1)) = flip(Geo.fixR(:,:,1:k-1), 3);
		end
	end
end