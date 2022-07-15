function writeDisptrac(u, t, Geo, fname)
    [~, top_idx] = ext_z(0, Geo);
%     ftfm  = fopen(fname,'w+');
    x  = vec_to_tfmvec(Geo.X(top_idx, 1), Geo);
    y  = vec_to_tfmvec(Geo.X(top_idx, 2), Geo);
% 	vecu = vec_to_tfmvec([u(top_idx, 1), u(top_idx, 2)], Geo);
%     vecux = vec_to_tfmvec(u(top_idx, 1), Geo);
%     vecuy = vec_to_tfmvec(u(top_idx, 2), Geo);
    vecux = u(top_idx, 1);
    vecuy = u(top_idx, 2);
	
    vectx = t(top_idx, 1);
    vecty = t(top_idx, 2);

    disptrac = [x, y, vecux, vecuy, vectx, vecty]; 

    save(fname, 'disptrac','-ascii');
%     fclose(ftfm);
end