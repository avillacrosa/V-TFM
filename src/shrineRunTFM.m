function [tx_t, ty_t] = shrineRunTFM(dt, E, nu, d, h, ux, uy, tmax)
    %% Define simulation parameters for TFM
    fprintf("> Initiating viscoelastic FEM solver for TFM \n")

    nz = 2;
	%% DISCLAIMERS FOR TFM CODE
	% - d is the distance (not inany case in pixels) between grid points
	% - however, disptracs have x, y coordinates in pixels not distances!
	%%
	Geo.ns        = [size(ux,1), size(ux,2), nz];
	Geo.ds        = [d, d, h/nz];

    Geo.uPR = zeros(Geo.ns(1)*Geo.ns(2)*Geo.ns(3), 3, size(ux,3));
    Geo.dim = 3;
    [~, zl_idx] = ext_z(0, Geo);
    for t = 1:size(ux,3)
% 		uxPR = vec_to_tfmvec(grid_to_vec(ux(:,:,t)), Geo);
% 		uyPR = vec_to_tfmvec(grid_to_vec(uy(:,:,t)), Geo);
		% Shrine format for its grid is that it first increments y then x,
		% while mine increments x then y (then z)
		ut = [grid_to_vec(ux(:,:,t)), grid_to_vec(uy(:,:,t))];
        Geo.uPR(zl_idx,[1,2],t) = ut;
	end
	% UX AND UY COME RIGHTLY ORDERED HERE SO WE SHOULD NOT DO ANYTHING
	
    Geo.uBC = [ 3 0 1 0; 3 0 2 0; 3 0 3 0; 3 h 3 0];
    
	Mat.E  = E; Mat.nu = nu;
	Mat.model = 'elastic'; Mat.elast = 'hookean';
	Mat.visco = 10;

	Set.dt     = dt; Set.dt_obs = Set.dt;
	Set.time_incr = tmax; Set.save_freq = 1;
	Set.output = true;
    Set.name = 'tfm_test';
	Set.Boussinesq = true;
    %% Run
	Result = runTFM(Geo, Mat, Set);

    %% Extract and return tractions
    tx_t = zeros(size(ux,1), size(uy,2), size(ux,3));
    ty_t = zeros(size(ux,1), size(uy,2), size(ux,3));
    for t = 1:size(ux,3)
        tx_t(:,:,t) = vec_to_grid(Result.t_top(:,1,t), Geo);
        ty_t(:,:,t) = vec_to_grid(Result.t_top(:,2,t), Geo);
    end
end

