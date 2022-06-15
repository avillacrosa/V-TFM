function [s, Int] = stress(k, e, gp, x_t, X, s_t, z, Mat, Set, Int)
	switch lower(Mat.model)
		case 'maxwell'
% 			[s, Int] = maxwell_s(k, e, gp, x_t, X, s_t, z, Mat, Set, Int);
			[s, Int] = maxwell_s_bf(k, e, gp, x_t, X, s_t, z, Mat, Set, Int);
		case 'fmaxwell'
			[s, Int] = fmaxwell_s(k, e, gp, x_t, X, s_t, z, Mat, Set, Int);
		case 'gmaxwell'
			[s, Int] = gmaxwell_s(k, e, gp, x_t, X, s_t, z, Mat, Set, Int);
		case 'elastic'
			s = stress_elast(k, x_t, X, z, Mat);
	end
end