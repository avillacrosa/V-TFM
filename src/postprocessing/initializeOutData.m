function Result = initializeOutData(Geo, Mat, Set)
	% TODO FIXME, change save_freq to total number of snapshots???
    n_saves = fix(Set.time_incr/Set.save_freq);
    
    Result.x        = zeros(Geo.n_nodes,Geo.dim, n_saves);
    Result.x(:,:,1) = Geo.X;
    Result.u        = zeros(Geo.n_nodes, Geo.dim, n_saves);
    Result.s        = zeros(Geo.vect_dim, Geo.n_nodes, n_saves);
    Result.F        = zeros(Geo.n_nodes, Geo.dim, n_saves);
	Result.T        = zeros(Geo.n_nodes, Geo.dim, n_saves);
    Result.t        = zeros(Geo.n_nodes, Geo.dim, n_saves);
    Result.X        = Geo.X; 
    Result.n        = Geo.n; 
    Result.dof      = Geo.dof;
    Result.fix      = Geo.fix;
    Result.time     = zeros(1, n_saves);
	if Set.nano
		Result.Tz   = zeros(n_saves,1);
		Result.uz   = zeros(n_saves,1);
	end
end