function [s, se, Q] = stress(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set)
	if strcmpi(Mat.model, 'maxwell')
		[s, se, Q] = maxwell_s(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'gmaxwell')
		[s, se, Q] = gmaxwell_s(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'kelvin')
		[s, se, Q] = kelvin_s(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'gkelvin')
		[s, se, Q] = gkelvin_s(k, x_t, X, s_t, se_t, Q_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'elastic')
		s = stress_elast(k, x_t, X, z, Mat);
		se = zeros(size(s));
		Q = zeros(size(s));
	end
end