function [s, se, Q] = maxwell_s(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set)
	Fd  = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	s	= stress_elast(k+1, x_t, X, z, Mat);

	tau	= Mat.visco/Mat.E;
	xi	= -Set.dt/(2*tau);	
	if strcmpi(Mat.elast,"hookean")
		se  = s;
		H	= exp(xi)*(exp(xi)*ref_mat(Q_t(:,1,:,:,k))-ref_mat(se_t(:,:,:,k)));
		Q	= exp(xi)*s+H;
		s   = Q;
	else
		S   = J*inv(Fd)*s*inv(Fd');
		se  = S;
		H	= exp(xi)*(exp(xi)*ref_mat(Q_t(:,1,:,:,k))-ref_mat(se_t(:,:,:,k)));
		Q	= exp(xi)*S+H;
		S	= Q;
		s   = Fd*S*Fd'/J;
	end
end