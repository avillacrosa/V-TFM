function [c, Int] = ctensor(k, e, gp, xe_t, X, z, Mat, Set, Int)
	switch lower(Mat.model)
		case 'maxwell'
% 			[c, Int]  = maxwell_c(k, e, gp, xe_t, X, z, Mat, Set, Int);
			[c, Int]  = maxwell_c_bf(k, e, gp, xe_t, X, z, Mat, Set, Int);
		case 'fmaxwell'
			[c, Int]  = fmaxwell_c(k, e, gp, xe_t, X, z, Mat, Set, Int);
		case 'gmaxwell'
			[c, Int]  = gmaxwell_c(k, e, gp, xe_t, X, z, Mat, Set, Int);
		case 'elastic'
			c  = ctensor_elast(xe_t, X, z, Mat);
	end
end			