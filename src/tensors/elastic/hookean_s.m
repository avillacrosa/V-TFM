function sigma = hookean_s(k, x, X, z, Mat, Set)
	Fd = deformF(x(:,:,k), X, z);
	dim = size(Fd, 1);
    lin_str = linStrain(Fd);
    % Ideally I would prefer computing c, then D, then sigma but that is
    % much more expensive because of looping...
    D = plane_stress(dim, Mat);
    sigma = D*vec_mat(lin_str, 2);
    sigma = ref_mat(sigma);
end