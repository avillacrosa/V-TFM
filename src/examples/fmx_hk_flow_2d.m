function [Geo, Mat, Set] = fmx_hk_flow_2d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
    Geo.ns = [3 3 1];
    Geo.ds = [1 1 1]/2;

    Geo.uBC = [1 0 1 0; 2 0 2 0;];
    Geo.tBC = [1 1 1 10];
    
    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'fmaxwell'; % Merge these two?
    Mat.elast  = 'hookean'; % Merge these two?
	Mat.c      = [0.01 100];
	Mat.cexp   = [1 0];
	Mat.E      = Mat.c(2);
    Mat.nu     = 0.0;

    %% Numerical settings
    Set.n_steps = 1;
    Set.time_incr = 30;
    Set.save_freq = 1;
% 	Set.dt = 0.1;
	
	Set.plot_stress = true;

    fname = dbstack;
	Set.name = fname.name;
end