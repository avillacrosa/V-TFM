function [Geo, Mat, Set] = mx_ve_flow_2d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
    Geo.ns = [3 3 1];
    Geo.ds = [1 1 1]/2;

    Geo.uBC = [1 0 1 0; 2 0 2 0;];
    Geo.tBC = [1 1 1 10];
    
    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'maxwell'; % Merge these two?
    Mat.elast  = 'venant'; % Merge these two?
	
	Mat.c      = [100 1];
	Mat.nu     = 0.3;
	Mat.E      = Mat.c(1);

    %% Numerical settings
    Set.n_steps = 1;
    Set.time_incr = 10;
    Set.save_freq = 1;

    fname = dbstack;
	Set.name = fname.name;
end