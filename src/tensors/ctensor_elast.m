function c = ctensor_elast(x, X, z, Mat)
	if strcmpi(Mat.elast, 'hookean')
		c = hookean_c(x, X, z, Mat);
	elseif strcmpi(Mat.elast, 'neohookean')
		c = neohookean_c(x, X, z, Mat);
	elseif strcmpi(Mat.elast, 'venant')
		c = venant_c(x, X, z, Mat);
	end
end