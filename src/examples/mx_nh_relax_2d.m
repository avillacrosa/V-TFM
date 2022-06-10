function [Geo, Mat, Set] = mx_nh_relax_2d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
    Geo.ns = [3 3 1];
    Geo.ds = [1 1 1]/2;

    Geo.uBC = [1 0 1 0; 2 0 2 0; 1 1 1 0.1];
    
    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'maxwell'; % Merge these two?
    Mat.elast  = 'neohookean'; % Merge these two?
    Mat.E     = 100;
    Mat.nu    = 0.3; % No off diagonal terms in D matrix
    Mat.visco = 0.01;

    %% Numerical settings
    Set.n_steps = 1;
    Set.time_incr = 20;
    Set.save_freq = 1;
	
	Set.plot_stress = true;

    fname = dbstack;
	Set.name = fname.name;
end