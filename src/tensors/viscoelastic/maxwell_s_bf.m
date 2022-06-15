function [s, Int] = maxwell_s_bf(k, e, gp, x_t, X, s_t, z, Mat, Set, Int)
	Fd  = deformF(x_t(:,:,k+1), X, z); J = det(Fd);
	se	= stress_elast(k+1, x_t, X, z, Mat);
	E = Mat.c(1);
	nu = Mat.c(2);
	tau	= nu/E;
	xi	= -Set.dt/(2*tau);	
	if strcmpi(Mat.elast,"hookean")
		% FORWARD
% 		Q = se-ref_mat(Int.se_t(:,e,gp,k))+ref_mat(Int.Q_t(:,1,e,gp,k))*(1-Set.dt/tau);
		% BACKWARD
		Q = (se-ref_mat(Int.se_t(:,e,gp,k))+ref_mat(Int.Q_t(:,1,e,gp,k)))*(tau/(tau+Set.dt));
% 		H	= exp(xi)*(exp(xi)*ref_mat(Int.Q_t(:,1,e,gp,k))-ref_mat(Int.se_t(:,e,gp,k)));
% 		Q	= exp(xi)*se+H;
		s   = Q;
		Int.se_t(:,e,gp,k+1) = vec_mat(se);
		Int.Q_t(:,:,e,gp,k+1) = vec_mat(Q);
	else
		Se  = J*inv(Fd)*se*inv(Fd');
		H	= exp(xi)*(exp(xi)*ref_mat(Int.Q_t(:,1,e,gp,k))-ref_mat(Int.Se_t(:,e,gp,k)));
		Q	= exp(xi)*Se+H;
		S	= Q;
		s   = Fd*S*Fd'/J;
		Int.Se_t(:,e,gp,k+1) = vec_mat(Se);
		Int.Q_t(:,:,e,gp,k+1) = vec_mat(Q);
	end
end