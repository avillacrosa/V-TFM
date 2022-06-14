function [sigma, Qegp] = stress(k, x_t, X, Q_t, z, Mat, Set)
	if strcmpi(Mat.model, 'maxwell')
		[sigma, Qegp] = maxwell_s(k, x_t, X, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'gmaxwell')
		[sigma, Qegp] = gmaxwell_s(k, x_t, X, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'kelvin')
		[sigma, Qegp] = kelvin_s(k, x_t, X, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'gkelvin')
		[sigma, Qegp] = gkelvin_s(k, x_t, X, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'elastic')
		sigma = stress_elast(k, x_t, X, z, Mat);
		Qegp = zeros(size(sigma));
	end
end