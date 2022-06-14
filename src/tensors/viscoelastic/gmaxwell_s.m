function [sigma, Q] = gmaxwell_s(k, x_t, X, Q_t, z, Mat, Set)
	Fd   = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	Fd_n = deformF(x_t(:,:,k), X, z);   J_n = det(Fd_n);
	sigma	= stress_elast(k+1, x_t, X, z, Mat);
	sigma_n = stress_elast(k, x_t, X, z, Mat);

	S   = J*inv(Fd)*sigma*inv(Fd');
	S_n = J_n*inv(Fd_n)*sigma_n*inv(Fd_n');

	Q = zeros(size(S,1), size(S,2), Mat.ve_elems);
	Qtot = zeros(size(S));
	if strcmpi(Mat.elast,"hookean")
		for a = 1:Mat.ve_elems
			tau    = Mat.visco(a)/Mat.Ea(a);
			xi     = -Set.dt/(2*tau);	
			H      = exp(xi)*(exp(xi)*ref_mat(Q_t(:,a,:,:,k))-sigma_n);
			Q(:,:,a)   = exp(xi)*sigma+H;
			Qtot   = Qtot + Q(:,:,a);
		end
		sigma = sigma + Qtot;
	else
		for a = 1:Mat.ve_elems
			tau    = Mat.visco(a)/Mat.Ea(a);
			xi     = -Set.dt/(2*tau);	
			H      = exp(xi)*(exp(xi)*ref_mat(Q_t(:,a,:,:,k))-S_n);
			Q(:,:,a)   = exp(xi)*S+H;
			Qtot   = Qtot + Q(:,:,a);
		end
		S = S + Qtot;
		sigma = Fd*S*Fd'/J;
	end
end