function c = ctensor(k, xe_t, X, Qe_t, z, Mat, Set)
	if strcmpi(Mat.model, 'maxwell')
		c = maxwell_c(k, xe_t, X, Qe_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'gmaxwell')
		c = gmaxwell_c(k, xe_t, X, Qe_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'kelvin')
		c = kelvin_c(k, xe_t, X, Qe_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'gkelvin')
		c = gkelvin_c(k, xe_t, X, Qe_t, z, Mat, Set);
	elseif strcmpi(Mat.model, 'elastic')
		c = ctensor_elast(xe_t, X, z, Mat);
	end
end			