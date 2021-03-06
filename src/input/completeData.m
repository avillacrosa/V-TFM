function [Geo, Mat,  Set] = completeData(Geo, Mat, Set)
    % Additional help variables
    Geo.n_nodes           = size(Geo.X,1);
    Geo.dim               = size(Geo.X,2);
    Geo.n_elem            = size(Geo.n,1);
    Geo.n_nodes_elem      = size(Geo.n,2);
    Geo.n_nodes_elem_c    = 2*(Geo.dim-1); % Square approximation...
    Geo.vect_dim          = (Geo.dim+1)*Geo.dim/2;
    [Geo.Kg1, Geo.Kg2]    = assembleK(Geo);
	Geo.u                 = zeros(Geo.n_nodes, Geo.dim, Set.time_incr);

    ns_ref = Geo.ns;
    ns_ref(1:Geo.dim) = 2;
    ds_ref = Geo.ds;
    ds_ref(1:Geo.dim) = 1;
    [~, Geo.n_ref, Geo.na_ref] = meshgen(ns_ref, ds_ref);

    [Set.quadx, Set.quadw]                     = gaussQuad(Set.n_quad);
    [Set.gaussPoints, Set.gaussWeights]        = buildQuadPoints(Geo, Set);
    [Set.gaussPointsC, Set.gaussWeightsC]      = buildQuadPointsC(Geo,Set);
%     [Set.gaussPointsNodes, Set.gaussWeightsNodes]      = buildQuadPointsNodes(Geo,Set);
    [Set.cn, Set.cEq, Set.gausscP, Set.gausscW]= buildAreaDep(Geo,Set);

    Geo.time = (1:Set.time_incr)*Set.dt;
    % It might be possible that the grid is already in the TFM input file
    % Try to read it from there if possible
    
	if isfield(Mat, 'nu') && isfield(Mat, 'E')
        Mat.lambda  = Mat.E*Mat.nu/((1+Mat.nu)*(1-2*Mat.nu));
        Mat.mu      = Mat.E/(2*(1+Mat.nu));
    elseif isfield(Mat, 'lambda') && isfield(Mat, 'mu')
        Mat.E       = Mat.mu*(3*Mat.lambda+2*Mat.mu)/(Mat.lambda+Mat.mu);
        Mat.nu      = Mat.lambda/(2*(Mat.lambda+Mat.mu));
	end
end