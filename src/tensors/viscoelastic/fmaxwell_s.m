% function [sigma, Q] = fmaxwell_s(k, x_t, X, Q_t, z, Mat, Set)
function [s, se, Q] = fmaxwell_s(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	s	= stress_elast(k+1, x_t, X, z, Mat);
	se = s;
	tau	= Mat.Ebeta/Mat.Ealpha;
	Q   = -Set.dt^(Mat.beta-Mat.alpha)*Q_t(:,1,:,:,k)/tau...
		  -glderivTensor(Q_t, k+1, Set.dt, Mat.beta-Mat.alpha, 2)...
		  +glderivTensor(se_t, k+1, Set.dt, Set.alpha, 1)*Set.dt^(Mat.beta-Mat.alpha);
	S	= Q;
	s = Fd*S*Fd'/J;
end