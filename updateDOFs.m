function [Geo, Set] = updateDOFs(k, x_t, Geo, Mat, Set)
	if Set.nano
		Set.r0(end) = Set.r0(end)+Set.v*Set.dt;
		fixR = false(Geo.n_nodes, Geo.dim);
		if Set.v < 0 % LOADING
			kx = max(k+Set.dk-1, 1);
			x_kv = ref_nvec(x_t(:,kx), Geo.n_nodes, Geo.dim);
			fixR(:,end) = vecnorm(x_kv-Set.r0, 2, 2)<Set.r;
		else
			kx = max(k+Set.dk-1, 1);
			fixR = Geo.fixR(:,:,k);
		end
		Geo.fixR(:,:,k)			= fixR;
		Geo.fix(logical(fixR))	= true;
		Geo.dof					= not(Geo.fix);

		if (Set.r0(end)-Set.r) <= (max(Geo.X(:,end))-Set.h)
			Set.v = -Set.v;
			Geo.fixR(:,:,(k+1):(2*k-1)) = flip(Geo.fixR(:,:,1:k-1), 3);
		end
	end
end
