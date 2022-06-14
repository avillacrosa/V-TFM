function Result = solveTFM(Geo, Mat, Set, Result)
    M  = areaMassLISP(Geo.X, Geo, Set);
	X = vec_nvec(Geo.X);
	u_t = vec_nvec(Geo.u);
    F = vec_nvec(Geo.F);

	stress_t = zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);
	strain_t = zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);
	Q_t		 = zeros(Geo.vect_dim, Mat.ve_elems, Geo.n_elem, Geo.n_nodes_elem, Set.time_incr);

	t = 0;
	for k = 1:Set.time_incr-Set.dk
        [T, ~, Q_t] = internalF(k, X + u_t, Q_t, Geo, Mat, Set);
    	R = T - F(:,k+Set.dk);
    	[u_t, stress_t(:,:,:,k+Set.dk), Q_t] = newton(k, u_t, Q_t, R, F(:,k+Set.dk), Geo, Mat, Set);
        if mod(k, Set.save_freq) == 0
			c = k/Set.save_freq + 1;
            Result = saveOutData(t, c, k, u_t, stress_t, strain_t, F, T, M, Geo, Mat, Set, Result);
            writeOut(c+1,Geo,Set,Result);

            fprintf("it = %4i, t = %.2f, |u| = ( ", k, t);
            fprintf("%.2f ", vecnorm(Result.u(:,:,c), 2, 1));
            fprintf("), |stress| = ( ")
            fprintf("%.2f ", vecnorm(Result.stress(:,:,c), 2, 2));
    		fprintf(") \n")
        end
        t = t + Set.dt;
	end
end