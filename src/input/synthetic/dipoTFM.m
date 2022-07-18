function [u, fixN] = dipoTFM(Geo, Set)
    u = zeros(Geo.n_nodes, Geo.dim, Set.time_incr);
	centralNode = Geo.ns(3)*Geo.ns(1)*Geo.ns(2) - Geo.ns(1)*round(Geo.ns(2)/2) + round((Geo.ns(1))/2);

	fixN = [centralNode + Set.dipole_d, centralNode - Set.dipole_d];
	for k = 1:Set.time_incr
		u(centralNode + Set.dipole_d,1,k) = Set.dipole_u;
		u(centralNode - Set.dipole_d,1,k) = -Set.dipole_u;
	end
end