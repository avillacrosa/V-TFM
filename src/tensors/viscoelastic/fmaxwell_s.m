function [sigma, Q] = fmaxwell_s(k, x_t, X, Q_t, z, Mat, Set)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	Fd_n = deformF(x_t(:,:,k), X, z);   J_n = det(Fd_n);
	sigma	= stress_elast(k+1, x_t, X, z, Mat);
	sigma_n = stress_elast(k, x_t, X, z, Mat);

	tau	= Mat.Ebeta/Mat.Ealpha;
	Q   = -Set.dt^(Mat.beta-Mat.alpha)*Q_t(:,1,:,:,k)/tau...
		  -glderivTensor(Q_t, k+1, Set.dt, Mat.beta-Mat.alpha, 2)...
		  +glderivTensor(S_t, k+1, Set.dt, Set.alpha, 1)*Set.dt^(Mat.beta-Mat.alpha);
	S	= Q;
	sigma = Fd*S*Fd'/J;
end