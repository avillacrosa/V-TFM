function [Geo, Mat, Set] = nano_hk_2d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
%     Geo.ns = [80 30 1];
%     Geo.ds = [1/79 1/29 1];

	n = 20;
    Geo.ns = [n n 1];
    Geo.ds = [1/(n-1) 1/(n-1) 1];

    Geo.uBC = [2 0 2 0; 2 0 1 0; % BOTTOM
			   1 1 1 0; 1 1 2 0; % RIGHT
		       1 0 1 0; 1 0 2 0; % LEFT
			   ];
    
    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'elastic'; % Merge these two?
	Mat.elast  = 'hookean';
	Mat.E    = 100;
    Mat.nu   = 0.3;

    %% Numerical settings
	Set.nano = true;
	Set.r    = 0.2;
	Set.r0   = [0.5, (Geo.ns(2)-1)*Geo.ds(2)+Set.r];
	Set.v    = -0.005;
	Set.h    = 0.10;
	Set.dt   = 1;
	
	Set.time_incr = -2*(Set.h/Set.v)/Set.dt;
	Set.time_incr = int8(Set.time_incr)+1;

    fname = dbstack;
	Set.name = fname.name;
end