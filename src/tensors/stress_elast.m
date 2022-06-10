function sigma = stress_elast(k, x_t, X, z, Mat)
	if strcmpi(Mat.elast, 'hookean')
		sigma = hookean_s(k, x_t, X, z, Mat);
	elseif strcmpi(Mat.elast, 'neohookean')
		sigma = neohookean_s(k, x_t, X, z, Mat);
	elseif strcmpi(Mat.elast, 'venant')
		sigma = venant_s(k, x_t, X, z, Mat);
	end
end