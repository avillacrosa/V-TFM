function [Geo, Mat, Set] = sls_nh_relax_3d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
    Geo.ns = [5 5 3];
    Geo.ds = [1/4 1/4 1/15];

	Geo.uBC = [3 0 1 0; 3 0 2 0; 3 0 3 0;
			   2 0 1 0; 2 0 2 0;
			   2 1 1 0; 2 1 2 0;
			   1 0 1 0; 1 0 2 0;
			   1 1 1 0; 1 1 2 0.4;];

    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'gmaxwell'; % Merge these two?
    Mat.elast  = 'neohookean'; % Merge these two?
    Mat.E      = 100;
    Mat.nu     = 0.3;
	Mat.c      = [100 0.01];
	Mat.cexp   = [0 1];

    %% Numerical settings
    Set.n_steps = 1;
    Set.time_incr = 20;
    Set.save_freq = 1;
	
	Set.plot_stress = true;

    fname = dbstack;
	Set.name = fname.name;
end