function [s, Int] = gmaxwell_s(k, e, gp, x_t, X, s_t, z, Mat, Set, Int)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	se	= stress_elast(k+1, x_t, X, z, Mat);

	Q = zeros(size(se,1), size(se,2), Mat.ve_elems);
	Qtot = zeros(size(se));
	if strcmpi(Mat.elast,"hookean")
		for a = 1:Mat.ve_elems
			tau    = Mat.c(a,2)/Mat.c(a,1);
% 			fact = (1-Set.dt/tau); % FORWARD
			fact = (tau/(tau+Set.dt)); % BACKWARD
			Q(:,:,a) = (se-ref_mat(Int.se_t(:,e,gp,k))+ref_mat(Int.Q_t(:,1,e,gp,k)))*fact;
			Qtot   = Qtot + Q(:,:,a);
			Int.Q_t(:,a,e,gp,k+1) = vec_mat(Q(:,:,a));
		end
		Int.se_t(:,e,gp,k+1) = vec_mat(se);
		s = se + Qtot;
	else
		Se   = J*inv(Fd)*se*inv(Fd');
		for a = 1:Mat.ve_elems
			tau    = Mat.c(a,2)/Mat.c(a,1);
			% 			fact = (1-Set.dt/tau); % FORWARD
			fact = (tau/(tau+Set.dt)); % BACKWARD
			Q(:,:,a)   =(Se-ref_mat(Int.Se_t(:,e,gp,k))+ref_mat(Int.Q_t(:,1,e,gp,k)))*fact;
			Qtot   = Qtot + Q(:,:,a);
			Int.Q_t(:,:,e,gp,k+1) = vec_mat(Q(:,:,a));
		end
		S = Se + Qtot;
		s = Fd*S*Fd'/J;
		Int.Se_t(:,e,gp,k+1) = vec_mat(Se);
	end
end