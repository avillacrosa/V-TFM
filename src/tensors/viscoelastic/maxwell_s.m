function [sigma, Q] = maxwell_s(k, x_t, X, Q_t, z, Mat, Set)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	Fd_n = deformF(x_t(:,:,k), X, z);   J_n = det(Fd_n);
	sigma	= stress_elast(k+1, x_t, X, z, Mat);
	sigma_n = stress_elast(k, x_t, X, z, Mat);

	tau	= Mat.visco/Mat.E;
	xi	= -Set.dt/(2*tau);	
	if strcmpi(Mat.elast,"hookean")
		H	= exp(xi)*(exp(xi)*ref_mat(Q_t(:,1,:,:,k))-sigma_n);
		Q	= exp(xi)*sigma+H;
		sigma = Q;
	else
		S   = J*inv(Fd)*sigma*inv(Fd');
		S_n = J_n*inv(Fd_n)*sigma_n*inv(Fd_n');
		H	= exp(xi)*(exp(xi)*ref_mat(Q_t(:,1,:,:,k))-S_n);
		Q	= exp(xi)*S+H;
		S	= Q;
		sigma = Fd*S*Fd'/J;
	end
end