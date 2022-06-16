function c = ctensor(k, xe_t, X, z, Mat, Set)
	switch lower(Mat.model)
		case 'maxwell'
			c  = maxwell_c(k, xe_t, X, z, Mat, Set);
		case 'fmaxwell'
			c  = fmaxwell_c(k, xe_t, X, z, Mat, Set);
		case 'gmaxwell'
			c  = gmaxwell_c(k, xe_t, X, z, Mat, Set);
		case 'elastic'
			c  = ctensor_elast(xe_t, X, z, Mat);
	end
end			