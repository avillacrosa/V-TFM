function Result = saveOutData(t, c, k, x, s_t, F, T, M, Geo, Mat, Set, Result)
    	[~, top_idx] = ext_z(0, Geo);
    	
        Result.time(c)       = t;    
        Result.x(:,:,c)      = ref_nvec(x(:,k+Set.dk), Geo.n_nodes, Geo.dim);
		Result.u(:,:,c)      = Result.x(:,:,c) - Geo.X;
		Result.s(:,:,c)      = recoverNodals(s_t(:,:,:,k+Set.dk), Geo, Set);
		Result.F(:,:,c)      = ref_nvec(F(:,k+Set.dk), Geo.n_nodes, Geo.dim); % This can be moved to Result definition.
		Result.T(:,:,c)      = ref_nvec(T, Geo.n_nodes, Geo.dim);
		Result.t(:,:,c)      = M \ Result.T(:,:,c);
		Result.t_top(:,:,c)  = Result.t(top_idx,:,c);
		if Set.nano
			Result.Tz(c) = -sum(Result.T(logical(Geo.fixR(:,k)),end,c));
			Result.uz(c) = max(Geo.X(:,end))+Set.r-Set.r0(end);
		end
		% TODO FIXME add tbssnsq here? 
end