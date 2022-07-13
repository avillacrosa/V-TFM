function [Q, x_t] = updateDirichlet(k, x_t, Geo, Mat, Set)
	Q = speye(Geo.n_nodes*Geo.dim);
	if Set.nano
		fullIdx = find(vec_nvec(Geo.fixR(:,:,k)));
    	Q = eye(Geo.n_nodes*Geo.dim);
		for id = 1:length(fullIdx)
			idx = fullIdx(id);
			dr = 0;
			for d = 1:Geo.dim-1
				dr = dr + (x_t(idx-d, k)-Set.r0(d)).^2;
			end
			
			for d = 1:Geo.dim-1
				q = +(x_t(idx-d,k)-Set.r0(d))/sqrt(Set.r^2-dr); 
				Q(idx, idx-d) = q; 
			end
			x_t(idx,k) = -sqrt(Set.r^2-dr)+Set.r0(end);
% 			q = +(x_t(idx-1,k)-Set.r0(1))/sqrt(Set.r^2-(x_t(idx-1,k)-Set.r0(1))^2); 
			Q(idx, idx) = 0;
		end
	end
end
