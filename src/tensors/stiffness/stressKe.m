function Ke = stressKe(k, e, xe, Xe, se, Geo, Mat, Set, Int)
    Ke     = zeros(Geo.n_nodes_elem*Geo.dim, Geo.n_nodes_elem*Geo.dim);
    for gp = 1:size(Set.gaussPoints,1)
        z = Set.gaussPoints(gp,:);

        [sigma, ~]  = stress(k, e, gp, xe, Xe, se(:,:,gp,:), z, Mat, Set, Int);
        [dNdx, J]   = getdNdx(xe(:,:,k+Set.dk), z, Geo.n_nodes_elem);
		
        for a = 1:Geo.n_nodes_elem
            for b = 1:Geo.n_nodes_elem
                sl_a_e = (Geo.dim*(a-1)+1):Geo.dim*a;
                sl_b_e = (Geo.dim*(b-1)+1):Geo.dim*b;

                Ke(sl_a_e, sl_b_e) = Ke(sl_a_e, sl_b_e)+ ...
                           J*dNdx(a,:)*sigma*dNdx(b,:)'*eye(Geo.dim)...
                                            *Set.gaussWeights(gp,:);
            end
        end
    end
end
