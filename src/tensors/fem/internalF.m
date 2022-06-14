%--------------------------------------------------------------------------
% Computation of the internal in both 2D and 3D
%--------------------------------------------------------------------------
function [T, s_t, se_t, Q_t] = internalF(k, x_t, s_t, se_t, Q_t, Geo, Mat, Set)
	x_t = ref_nvec(x_t, Geo.n_nodes, Geo.dim);
	T = zeros(Geo.n_nodes*Geo.dim, 1);
	for e = 1:Geo.n_elem
		xe   = x_t(Geo.n(e,:),:,:);
		Xe   = Geo.X(Geo.n(e,:),:);
		s_e  = zeros(Geo.vect_dim, Geo.n_nodes_elem);
		se_e = zeros(Geo.vect_dim, Geo.n_nodes_elem);
		Q_e  = zeros(Geo.vect_dim, Mat.ve_elems, Geo.n_nodes_elem);
		for m = 1:size(xe,1)
			int = zeros(Geo.dim, 1);
			for gp = 1:size(Set.gaussPoints,1)
				z = Set.gaussPoints(gp,:);
				s_t_egp = s_t(:,e,gp,:);
				se_t_egp = se_t(:,e,gp,:);
				Q_t_egp = Q_t(:,:,e,gp,:);
				[ss_egp, ses_egp, Qs_e] = stress(k, xe, Xe, s_t_egp, se_t_egp, Q_t_egp, z, Mat, Set);

				s_e(:,gp) = vec_mat(ss_egp, 1);
				se_e(:,gp) = vec_mat(ses_egp, 1);
				for a = 1:Mat.ve_elems
					Q_e(:,a,gp)     = vec_mat(Qs_e(:,:,a), 1);
				end

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
		se_t(:,e,:,k+Set.dk)  = se_e;
		Q_t(:,:,e,:,k+Set.dk) = Q_e;
	end
end