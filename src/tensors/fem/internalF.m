%--------------------------------------------------------------------------
% Computation of the internal in both 2D and 3D
%--------------------------------------------------------------------------
function [T, s_t, Int] = internalF(k, x_t, s_t, Geo, Mat, Set, Int)
	x_t = ref_nvec(x_t, Geo.n_nodes, Geo.dim);
	T = zeros(Geo.n_nodes*Geo.dim, 1);
	for e = 1:Geo.n_elem
		xe   = x_t(Geo.n(e,:),:,:);
		Xe   = Geo.X(Geo.n(e,:),:);
		s_e  = zeros(Geo.vect_dim, Geo.n_nodes_elem);
		for m = 1:size(xe,1)
			int = zeros(Geo.dim, 1);
			for gp = 1:size(Set.gaussPoints,1)
				z = Set.gaussPoints(gp,:);
				[ss_egp, Int] = stress(k, e, gp, xe, Xe, s_t, z, Mat, Set, Int);
				s_e(:,gp) = vec_mat(ss_egp, 1);
				if strcmpi(Mat.elast,"hookean")
					[dNdx, J] = getdNdx(Xe, z, Geo.n_nodes_elem);
				else
					[dNdx, J] = getdNdx(xe(:,:,k+Set.dk), z, Geo.n_nodes_elem);
				end
				int = int + ss_egp*dNdx(m,:)'*J*Set.gaussWeights(gp,:);
			end
			glob_idx = (Geo.dim*(Geo.n(e,m)-1)+1):Geo.dim*Geo.n(e,m);
			T(glob_idx) = T(glob_idx) + int;
		end
		s_t(:,e,:,k+Set.dk)   = s_e;
	end
end