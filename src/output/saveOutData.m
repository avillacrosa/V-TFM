function Result = saveOutData(t, c, k, u, s_t, S_t, F, T, M, Geo, Mat, Set, Result)
    	[~, top_idx] = ext_z(0, Geo);
    	
        Result.time(c)       = t;
        Result.u(:,:,c)      = ref_nvec(u(:,k+Set.dk), Geo.n_nodes, Geo.dim);        
        Result.x(:,:,c)      = Geo.X + Result.u(:,:,c);
		Result.s(:,:,c)      = recoverNodals(s_t(:,:,:,k+Set.dk), Geo, Set);
		Result.F(:,:,c)      = ref_nvec(F(:,k+Set.dk), Geo.n_nodes, Geo.dim); % This can be moved to Result definition.
		Result.T(:,:,c)      = ref_nvec(T, Geo.n_nodes, Geo.dim);
		Result.t(:,:,c)      = M \ Result.T(:,:,c);
		Result.t_top(:,:,c)  = Result.t(top_idx,:,c);
		% TODO FIXME add tbssnsq here? 
end