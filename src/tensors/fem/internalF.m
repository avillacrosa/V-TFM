%--------------------------------------------------------------------------
% Computation of the internal in both 2D and 3D
%--------------------------------------------------------------------------
function [T, sigmas, Q_t] = internalF(k, x_t, Q_t, Geo, Mat, Set)
	x_t = ref_nvec(x_t, Geo.n_nodes, Geo.dim);
	T = zeros(Geo.n_nodes*Geo.dim, 1);
	sigmas = zeros(Geo.vect_dim, Geo.n_elem, Geo.n_nodes_elem);
	for e = 1:Geo.n_elem
		xe = x_t(Geo.n(e,:),:,:);
		Xe = Geo.X(Geo.n(e,:),:);
		sigmas_e = zeros(Geo.vect_dim, Geo.n_nodes_elem);
		qs     = zeros(Geo.vect_dim, Mat.ve_elems, Geo.n_nodes_elem);
		for m = 1:size(xe,1)
			int = zeros(Geo.dim, 1);
			for gp = 1:size(Set.gaussPoints,1)
				z = Set.gaussPoints(gp,:);
				[sigma, q] = stress(k, xe, Xe, Q_t(:,:,e,gp,:), z, Mat, Set);
				sigmas_e(:,gp) = vec_mat(sigma, 1);
				for a = 1:Mat.ve_elems
					qs(:,a,gp)     = vec_mat(q(:,:,a), 1);
				end
				if strcmpi(Mat.elast,"hookean")
					[dNdx, J] = getdNdx(Xe, z, Geo.n_nodes_elem);
				else
					[dNdx, J] = getdNdx(xe(:,:,k+Set.dk), z, Geo.n_nodes_elem);
				end
				int = int + sigma*dNdx(m,:)'*J*Set.gaussWeights(gp,:);
			end
			glob_idx = (Geo.dim*(Geo.n(e,m)-1)+1):Geo.dim*Geo.n(e,m);
			T(glob_idx) = T(glob_idx) + int;
		end
		sigmas(:,e,:) = sigmas_e;
		Q_t(:,:,e,:,k+Set.dk) = qs;
	end
end