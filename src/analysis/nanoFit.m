function [Geo, Mat, Set] = nanoFit(expFile, Geo, Mat, Set)
	[Mat.E, Set.r, data] = readNanoFile(expFile);
	
	%% Geometry parameters
	lx = 8*Set.r; ly = lx; lz = 2*1.0775e-04;
	nx = 30; ny = nx; nz = 4;
	Geo.ns = [nx ny nz];
	Geo.ds = [lx/(nx-1) ly/(ny-1) lz/(nz-1)];
	Geo.uBC = [3 0 1 0; 3 0 2 0; 3 0 3 0;];
	
	%% Material parameters
	Mat.model  = 'elastic'; % Merge these two?
	Mat.elast  = 'hookean';
	Mat.nu     = 0.457;
	
	%% Numerical settings
	Set.time_incr = 30;	
	TIME = 1; INDENT = 3; 

	data = data(data(:,INDENT)>1,:);
	maxidx = data(:,INDENT) == max(data(:,INDENT));
	data = data(1:find(maxidx),:);
	simpoints = int16(linspace(1, size(data,1), Set.time_incr/2+1));
	data = data(simpoints,:);

	Set.nano = true;
	Set.dt = data(2,TIME)-data(1,TIME);
	Set.h = [data(:,INDENT); flip(data(1:end-1,INDENT))]*10^-9;
	Set.time_incr = Set.time_incr + 1;
	Set.r0   = [lx/2, ly/2, lz+Set.r];
	Set.r0i   = Set.r0;
	Set.name = 'RealNanoTest';
end