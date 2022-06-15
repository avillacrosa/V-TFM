function sigma = stress_elast(k, x_t, X, z, Mat)
	switch lower(Mat.elast)
		case 'hookean'
			sigma = hookean_s(k, x_t, X, z, Mat); % nu and E
		case 'neohookean'
			sigma = neohookean_s(k, x_t, X, z, Mat); % mu and lambda
		case 'venant'
			sigma = venant_s(k, x_t, X, z, Mat); % mu and lambda
	end
end