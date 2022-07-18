function [Geo, Mat, Set] = dipole_3d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
    Geo.ns = [50 50 3];
    Geo.ds = [1/49 1/49 1/15];

	Geo.uBC = [3 0 1 0; 3 0 2 0; 3 0 3 0;
			   2 0 1 0; 2 0 2 0;
			   2 1 1 0; 2 1 2 0;
			   1 0 1 0; 1 0 2 0;
			   1 1 1 0; 1 1 2 0;];
	Geo.uPR = 'dipole';
	Set.dipole_d = 1;
	Set.dipole_u = 1;

    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'elastic'; % Merge these two?
    Mat.elast  = 'hookean'; % Merge these two?
	Mat.E      = 100;
    Mat.nu     = 0.3;

    %% Numerical settings
	Set.dipole = true;
	Set.dipole_d = 1;
	Set.dipole_u = 0.2*Geo.ds(1);
	Set.time_incr = 1;

    fname = dbstack;
	Set.name = fname.name;
end