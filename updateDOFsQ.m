function [Q, Geo, Set] = updateDOFsQ(k, x_t, Geo, Mat, Set)
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
	    Q = eye(Geo.n_nodes*Geo.dim);
%         Q(fixR, fixR) = 0;
        fixR = vec_nvec(fixR);
        fullIdx = 1:size(Q,1);
        fullIdx = fullIdx(fixR);
        for id = 1:length(fullIdx)
            idx = fullIdx(id);
            q = -(x_t(idx-1,kx)-Set.r0(1))/sqrt(Set.r^2+(x_t(idx-1,kx)-Set.r0(1))^2);
            Q(idx, idx-1) = q; 
            Q(idx, idx) = 0;  
        end
    end
end
