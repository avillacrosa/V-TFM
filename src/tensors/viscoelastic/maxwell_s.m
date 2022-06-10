function [sigma, Q] = maxwell_s(k, x_t, X, Q, z, Mat, Set)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	Fd_n = deformF(x_t(:,:,k), X, z);   J_n = det(Fd_n);

	sigma	= stress_elast(k+1, x_t, X, z, Mat);
	sigma_n = stress_elast(k, x_t, X, z, Mat);

	S   = J*inv(Fd)*sigma*inv(Fd');
	S_n = J_n*inv(Fd_n)*sigma_n*inv(Fd_n');

	for a = 1:Mat.ve_elems
		tau = Mat.visco(a)/Mat.E(a);
		xi  = -Set.dt/(2*tau);	
		H   = exp(xi)*(exp(xi)*ref_mat(Q(:,a,:,:,k))-S_n);
		Q   = exp(xi)*S+H;
	end

	if Mat.Einf ~= 0
		S = S + Q;
	else
		S = Q;
	end
	sigma = Fd*S*Fd'/J;
end