function x = getSpherex(r0, r)
	npoints = 100; 
	x = zeros(npoints,2);
	for n = 1:npoints
		theta = n/npoints*2*pi;
		x(n,:) = [r0(1)+r*cos(theta), r0(2)+r*sin(theta)];
	end
end