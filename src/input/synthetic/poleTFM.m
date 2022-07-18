function [u, fixN] = poleTFM(Geo, Set)
    u = zeros(Geo.n_nodes, Geo.dim, Set.time_incr);
	centralNode = Geo.ns(3)*Geo.ns(1)*Geo.ns(2) - Geo.ns(1)*round(Geo.ns(2)/2) + round((Geo.ns(1))/2);
	fixN = centralNode;
	for k = 1:Set.time_incr
		u(centralNode,1,k) = Set.pole_u;
	end
end