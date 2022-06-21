function [Geo, Set] = updateDOFs(k, x_t, Geo, Mat, Set)
	if Set.nano
		kx = max(k+Set.dk-1, 1);
		x_k = ref_nvec(x_t(:,kx), Geo.n_nodes, Geo.dim);
		fix = Geo.fix;

		if (Set.r0(end)-Set.r) <= (max(Geo.X(:,end))-Set.h)
			Set.v = -Set.v;
			Geo.fixR(:,k:(2*(k-1)-1)) = flip(Geo.fixR(:,1:k-2), 2);
		end
		Set.r0(end) = Set.r0(end)+Set.v*Set.dt;
		if Set.v < 0 % LOADING
			fixR = vecnorm(x_k-Set.r0, 2, 2)<Set.r;
		else
			fixR = logical(Geo.fixR(:,k));
		end

		Geo.fixR(:,k) = fixR;
		fix(fixR,end) = true;
		Geo.dof = not(fix);
	end
end
