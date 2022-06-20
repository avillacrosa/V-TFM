function x_t = updateDirichlet(k, x_t, Geo, Mat, Set)
	if Set.nano
		x_k = ref_nvec(x_t(:,k), Geo.n_nodes, Geo.dim);
		r = Set.r;
		fixR = logical(Geo.fixR(:,k));
		x_k(fixR,2) = -sqrt(r^2-(x_k(fixR,1)-Set.r0(1)).^2)+Set.r0(2);
		x_t(:,k) = vec_nvec(x_k);
	end
end
