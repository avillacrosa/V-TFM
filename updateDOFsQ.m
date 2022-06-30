function [Q, Geo, Set] = updateDOFsQ(k, x_t, Geo, Mat, Set)
	if Set.nano
	
		fixR = false(Geo.n_nodes, Geo.dim);
		if Set.v < 0 % LOADING
			kx = max(k+Set.dk-1, 1);
			x_kv = ref_nvec(x_t(:,kx), Geo.n_nodes, Geo.dim);
			fixR(:,end) = vecnorm(x_kv-Set.r0, 2, 2)<Set.r;
		else
			kx = max(k+Set.dk-1, 1);
			fixR = Geo.fixR(:,:,k);
		end

    	Q = eye(Geo.n_nodes*Geo.dim);
		fullIdx = find(vec_nvec(fixR));
		% TODO FIXME THIS IS 2D NO? OH YEAH!
		for id = 1:length(fullIdx)
			idx = fullIdx(id);
			q = +(x_t(idx-1,k)-Set.r0(1))/sqrt(Set.r^2-(x_t(idx-1,k)-Set.r0(1))^2); 
			Q(idx, idx-1) = q; 
			Q(idx, idx) = 0;
		end

		Geo.fixR(:,:,k) = fixR;
		Geo.fix(logical(fixR))	= true;
		Geo.dof					= not(Geo.fix);

% 		Q = eye(size(Q));
	end
end
