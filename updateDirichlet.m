function x_t = updateDirichlet(k, x_t, Geo, Mat, Set)
	if Set.nano
		x_k = ref_nvec(x_t(:,k), Geo.n_nodes, Geo.dim);
		r = Set.r;
		fixR = logical(Geo.fixR(:,k));
		dofsq = 0;
		for d = 1:Geo.dim-1
			dofsq = dofsq + (x_k(fixR,d)-Set.r0(d)).^2;
		end
		x_k(fixR,end) = -sqrt(r^2-dofsq)+Set.r0(end);
		x_t(:,k) = vec_nvec(x_k);
	end
end