function [tx_t, ty_t] = shrineRunTFM(dt, E, nu, d, h, ux, uy, tmax)
    %% Define simulation parameters for TFM
    fprintf("> Initiating viscoelastic FEM solver for TFM \n")

    nz = 2;
	%% DISCLAIMERS FOR TFM CODE
	% - d is the distance (not inany case in pixels) between grid points
	% - however, disptracs have x, y coordinates in pixels not distances!
	% - because of PIVlab, ux and uy are transposed, with its first
	% dimension being y and the second x...
	%%


	Geo.ns        = [size(ux,2), size(ux,1), nz];
	Geo.ds        = [d, d, h/nz];

    Geo.uPR = zeros(Geo.ns(1)*Geo.ns(2)*Geo.ns(3), 3, size(ux,3));
    Geo.dim = 3;
    [~, zl_idx] = ext_z(0, Geo);
	for t = 1:size(ux,3)
		uxt = ux(:,:,t)';
		uyt = uy(:,:,t)';
% 		uxPR = ux(:,:,t)';
% 		uyPR = uy(:,:,t)';
		% Shrine format for its grid is that it first increments y then x,
		% while mine increments x then y (then z)
    	Geo.uPR(zl_idx,[1,2],t) = [uxt(:), uyt(:)];
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
    tx_t = zeros(Geo.ns(2), Geo.ns(1), size(ux,3));
    ty_t = zeros(Geo.ns(2), Geo.ns(1), size(ux,3));
    for t = 1:size(ux,3)
        tx_t(:,:,t) = vec_to_grid(Result.t_top(:,1,t), Geo)';
        ty_t(:,:,t) = vec_to_grid(Result.t_top(:,2,t), Geo)';
    end
end

