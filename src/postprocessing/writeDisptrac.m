function writeDisptrac(u, t, Geo, fname)
    [~, top_idx] = ext_z(0, Geo);
    x  = vec_to_tfmvec(Geo.X(top_idx, 1), Geo);
    y  = vec_to_tfmvec(Geo.X(top_idx, 2), Geo);
    vecux = vec_to_tfmvec(u(top_idx, 1), Geo);
    vecuy = vec_to_tfmvec(u(top_idx, 2), Geo);
    vectx = vec_to_tfmvec(t(top_idx, 1), Geo);
    vecty = vec_to_tfmvec(t(top_idx, 2), Geo);

    disptrac = [x, y, vecux, vecuy, vectx, vecty]; 

    save(fname, 'disptrac','-ascii');
end