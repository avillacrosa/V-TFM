function [Geo, Mat, Set] = nano_hk_3d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
%     Geo.ns = [50 50 3];
%     Geo.ds = [1/49 1/49 1/15];
	n = 15;
    Geo.ns = [n n 3];
    Geo.ds = [1/(n-1) 1/(n-1) 1/15];

	Geo.uBC = [3 0 1 0; 3 0 2 0; 3 0 3 0;
			   2 0 1 0; 2 0 2 0;
			   2 1 1 0; 2 1 2 0;
			   1 0 1 0; 1 0 2 0;
			   1 1 1 0; 1 1 2 0;];

%     Geo.uBC = [1 0 1 0; 1 0 2 0; 1 0 3 0; %BASE
% 			   2 0 1 0; 2 0 3 0; % RIGHT SIDE
% 			   2 1 1 0; 2 1 3 0; % LEFT SIDE
% 			   3 0 1 0; 3 0 2 0; % FRONT SIDE
% 			   3 1 1 0; 3 1 2 0; % BACK SIDE
% 			   ];

    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'elastic'; % Merge these two?
	Mat.elast  = 'hookean';
	Mat.E    = 100;
    Mat.nu   = 0.3;

    %% Numerical settings
	Set.nano = true;
	Set.r    = 0.2;
	Set.r0   = [0.5, 0.5, (Geo.ns(3)-1)*Geo.ds(3)+Set.r];
	Set.v    = -0.0005;
	Set.h    = 0.10;
	Set.dt   = 1;
	
	Set.time_incr = -2*(Set.h/Set.v)/Set.dt;
	Set.time_incr = int16(Set.time_incr)+1;

	Set.name = 'nano3D';
end