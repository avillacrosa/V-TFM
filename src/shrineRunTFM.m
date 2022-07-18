function [tx_t, ty_t] = shrineRunTFM(dt, E, nu, d, h, ux, uy, nz)
    %% Define simulation parameters for TFM
    fprintf("> Initiating viscoelastic FEM solver for TFM \n")

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
    	Geo.uPR(zl_idx,[1,2],t) = [uxt(:), uyt(:)];
	end
	
%     Geo.uBC = [ 3 0 1 0; 3 0 2 0; 3 0 3 0; 3 h 3 0];
    Geo.uBC = [ 3 0 1 0; 3 0 2 0; 3 0 3 0];

    
	Mat.E  = E; Mat.nu = nu;
	Mat.model = 'elastic'; Mat.elast = 'hookean';

	Set.dt     = dt; Set.dt_obs = Set.dt;
% 	Set.time_incr = size(ux,3); 
	Set.time_incr = 1; 
	Set.save_freq = 1;
	Set.output = true;
    Set.name = sprintf('tfm_fem_nz%d', nz);
	Set.Boussinesq = false;
    %% Run
	Result = runTFM(Geo, Mat, Set);

    %% Extract and return tractions
    tx_t = zeros(Geo.ns(2), Geo.ns(1), size(ux,3)); % This is fine
    ty_t = zeros(Geo.ns(2), Geo.ns(1), size(ux,3)); % This is fine
    for t = 1:Set.time_incr
        tx = vec_to_grid(Result.t_top(:,1,t), Geo)';
        ty = vec_to_grid(Result.t_top(:,2,t), Geo)';
		tx_t(:,:,t) = tx;
		ty_t(:,:,t) = ty;
    end
end

