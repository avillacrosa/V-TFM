function gl = glderiv(f, k, dt, rho, j0, cutoff)
	if (~exist('cutoff', 'var'))
		cutoff = k+5;
	end
	if (~exist('j0', 'var'))
		j0 = 1;
	end
	dims = repmat({':'},1,ndims(f)-1);
	sizef = size(f);
	gl = zeros(sizef(1:end-1));
    lambda = 1;
    for j = 1:k 
% 		fprintf("k: %d k-j+1: %d\n", k, k-j+1);
        if j >= j0
            gl = gl + double(lambda).*f(dims{:},k-j+1);
        end
        lambda = lambda*(j-1-rho)/j;
		if j > cutoff
			break
		end
    end
    gl = gl*dt^(-rho);
end