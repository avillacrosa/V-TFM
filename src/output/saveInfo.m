function Result = saveInfo(Geo, Mat, Set, Result)

    [~, top_idx] = ext_z(0, Geo);
    
    Result.t_top = Result.t(top_idx,:);
    
    ux = Geo.u(top_idx, 1);
    ux = reshape(ux, [Geo.ns(1), Geo.ns(2)]);
    uy = Geo.u(top_idx, 2);
    uy = reshape(uy, [Geo.ns(1), Geo.ns(2)]);
    [tx,ty] = inverseBSSNSQ(Mat.E,Mat.nu,Geo.ds(1),Geo.ds(3)*(Geo.ns(3)-1),ux,uy,1);
    Result.t_bssnsq(:,[1,2]) = [vec_nvec(tx),vec_nvec(ty)];

    save(fullfile(Set.DirOutput,sprintf('result.mat')), 'Result');
end