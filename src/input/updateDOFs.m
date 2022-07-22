function [Geo, Set] = updateDOFs(k, x_t, Geo, Mat, Set)
	if Set.nano
		Set.r0(end) = Set.r0i(end) - Set.h(k);
		if k-1 > 0
			load_cond = (Set.h(k) - Set.h(k-1))>0;
		else
			load_cond = (Set.h(k) - 0)>0;
		end
		fixR = false(Geo.n_nodes, Geo.dim);
		if load_cond % LOADING
			kx = max(k+Set.dk-1, 1);
			x_kv = ref_nvec(x_t(:,kx), Geo.n_nodes, Geo.dim);
			fixR(:,end) = vecnorm(x_kv-Set.r0, 2, 2)<Set.r;
		else
			fixR = Geo.fixR(:,:,k);
		end
		Geo.fixR(:,:,k)			= fixR;
		Geo.fix(logical(fixR))	= true;
		Geo.dof					= not(Geo.fix);
		if Set.h(k) == max(Set.h)
			Geo.fixR(:,:,(k+1):(2*k-1)) = flip(Geo.fixR(:,:,1:k-1), 3);
		end
	end
end
