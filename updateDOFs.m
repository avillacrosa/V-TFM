function [Geo, Set] = updateDOFs(k, x_t, Geo, Mat, Set)
	if Set.nano
		kx = max(k+Set.dk-1, 1);
		x_k = ref_nvec(x_t(:,kx), Geo.n_nodes, Geo.dim);
		fix = Geo.fix;

		if (Set.r0(2)-Set.r) <= (max(Geo.X(:,2))-Set.h)
			Set.v = -Set.v;
		end
		Set.r0(2) = Set.r0(2)+Set.v*Set.dt;
		if Set.v < 0 % LOADING
			fixR = vecnorm(x_k-Set.r0, 2, 2)<Set.r;
		elseif Set.v > 0 % UNLOADING
			fixR = logical(Geo.fixR(:,Set.time_incr-k+2));
		end
		Geo.fixR(:,k) = fixR;
		fix(fixR,2) = true;
		Geo.dof = not(fix);
	end
end
