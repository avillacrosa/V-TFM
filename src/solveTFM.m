function Result = solveTFM(Geo, Mat, Set, Result)
    M   = areaMassLISP(Geo.X, Geo, Set);
	X   = vec_nvec(Geo.X);
	u_t = vec_nvec(Geo.u);
    F_t = vec_nvec(Geo.F);
	s_t = zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);

	% Internal variables / history 
	Int.Q_t		= zeros(Geo.vect_dim, Mat.ve_elems, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);
	Int.se_t	= zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);
	Int.Se_t	= zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);
	Int.ce_t		= zeros(Geo.dim, Geo.dim, Geo.dim, Geo.dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);

	t = 0;
	for k = 1:Set.time_incr-Set.dk
        [T, ~, ~] = internalF(k, X + u_t, s_t, Geo, Mat, Set, Int);

    	R = T - F_t(:,k+Set.dk);

    	[u_t, s_t, Int] = newton(k, u_t, s_t, R, F_t, Geo, Mat, Set, Int);
		
        if mod(k, Set.save_freq) == 0
			c = k/Set.save_freq + 1;
            Result = saveOutData(t, c, k, u_t, s_t, F_t, T, M, Geo, Mat, Set, Result);
            writeOut(c,Geo,Set,Result);

            fprintf("it = %4i, t = %.2f, |u| = ( ", k, t);
            fprintf("%.2f ", vecnorm(Result.u(:,:,c), 2, 1));
            fprintf("), |stress| = ( ")
            fprintf("%.2f ", vecnorm(Result.s(:,:,c), 2, 2));
    		fprintf(") \n")
        end
        t = t + Set.dt;
	end
end