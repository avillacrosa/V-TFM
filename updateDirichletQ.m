function x_t = updateDirichletQ(k, x_t, Geo, Mat, Set)
	if Set.nano
		fullIdx = find(vec_nvec(Geo.fixR(:,:,k)));
		for id = 1:length(fullIdx)
			idx = fullIdx(id);
			dr = 0;
			for d = 1:Geo.dim-1
				dr = dr + (x_t(idx-d, k)-Set.r0(d)).^2;
			end
			x_t(idx,k) = -sqrt(Set.r^2-dr)+Set.r0(end);
		end
	end
end
