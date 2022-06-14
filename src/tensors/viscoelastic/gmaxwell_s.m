function [s, se, Q] = gmaxwell_s(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	s	= stress_elast(k+1, x_t, X, z, Mat);

	Q = zeros(size(s,1), size(s,2), Mat.ve_elems);
	Qtot = zeros(size(s));
	if strcmpi(Mat.elast,"hookean")
		se = s;
		for a = 1:Mat.ve_elems
			tau    = Mat.visco(a)/Mat.Ea(a);
			xi     = -Set.dt/(2*tau);	
			H      = exp(xi)*(exp(xi)*ref_mat(Q_t(:,a,:,:,k))-ref_mat(se_t(:,:,:,k)));
			Q(:,:,a)   = exp(xi)*s+H;
			Qtot   = Qtot + Q(:,:,a);
		end
		s = s + Qtot;
	else
		S   = J*inv(Fd)*s*inv(Fd');
		se  = S;
		for a = 1:Mat.ve_elems
			tau    = Mat.visco(a)/Mat.Ea(a);
			xi     = -Set.dt/(2*tau);	
			H      = exp(xi)*(exp(xi)*ref_mat(Q_t(:,a,:,:,k))-ref_mat(se_t(:,:,:,k)));
			Q(:,:,a)   = exp(xi)*S+H;
			Qtot   = Qtot + Q(:,:,a);
		end
		S = S + Qtot;
		s = Fd*S*Fd'/J;
	end
end