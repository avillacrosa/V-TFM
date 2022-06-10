function [Geo, Mat, Set] = hk_u_2d(Geo, Mat, Set)
    %% Geometry parameters
    % Number of nodes in each direction
    Geo.ns = [3 3 1];
    Geo.ds = [1 1 1]/2;

    Geo.uBC = [1 0 1 0; 2 0 2 0; 1 1 1 0.1];
    
    %% Material parameters
    % Possible types = hookean, neohookean, venant
    Mat.model  = 'elastic'; % Merge these two?
	Mat.elast  = 'hookean';
    Mat.E      = 100;
    Mat.nu     = 0.3; % No off diagonal terms in D matrix

    %% Numerical settings
    Set.n_steps = 1;

    fname = dbstack;
	Set.name = fname.name;
end