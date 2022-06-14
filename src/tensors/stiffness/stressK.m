function K = stressK(k, x, Q_t, Geo, Mat, Set)
	x = ref_nvec(x, Geo.n_nodes, Geo.dim);
	Kg1 = Geo.Kg1; Kg2 = Geo.Kg2;
	if Set.sparse
		ll = Geo.n_nodes_elem*Geo.dim;
		K_id1 = zeros(ll^2*Geo.n_elem,1);
		K_id2 = zeros(ll^2*Geo.n_elem,1);
		K = zeros(ll^2*Geo.n_elem,1);
		c = 1;
	else
		K   = zeros(Geo.n_nodes*Geo.dim);
	end
	if strcmpi(Mat.elast, 'hookean')
		return
	end
	for e = 1:Geo.n_elem
		ne = Geo.n(e,:);
		xe = x(ne,:,:);
		Xe = Geo.X(ne,:,:);
		Ke = stressKe(k, xe, Xe, Q_t(:,:,e,:,:), Geo, Mat, Set);
		if Set.sparse
			for aa = 1:size(Ke,1)
				for bb = 1:size(Ke,2)
					K_id1(c) = Kg1(aa,e);
					K_id2(c) = Kg2(bb,e);
					K(c) = Ke(aa,bb);
					c = c+1;
				end
			end
		else
			K(Kg1(:,e), Kg2(:,e)) = K(Kg1(:,e), Kg2(:,e)) + Ke;
		end
	end
	
	if Set.sparse
		K = sparse(K_id1, K_id2, K);
	end
end