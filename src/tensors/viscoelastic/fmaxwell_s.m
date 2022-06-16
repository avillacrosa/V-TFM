function [s, Int] = fmaxwell_s(k, e, gp, x_t, X, s_t, z, Mat, Set, Int)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	se	= stress_elast(k+1, x_t, X, z, Mat);
	ea = Mat.c(1); a = Mat.cexp(1);
	eb = Mat.c(2); b  = Mat.cexp(2);

	if strcmpi(Mat.elast,"hookean")
		Int.se_t(:,e,gp,k+1) = vec_mat(se);
		tau = ea/eb;
		fact = tau*Set.dt^(a-b)/(Set.dt^(a-b)+tau);
		Int.Q_t(:,:,e,gp,k+1) = fact*(...
			glderiv(Int.se_t(:,e,gp,:), k+1, Set.dt, a, 1)...
			-glderiv(Int.Q_t(:,1,e,gp,:), k+1, Set.dt, a-b, 2));
		s = ref_mat(Int.Q_t(:,:,e,gp,k+1));
	end
end