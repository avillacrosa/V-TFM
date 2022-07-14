function writeDisptrac(u, t, Geo, fname)
    [~, top_idx] = ext_z(0, Geo);
    ftfm  = fopen(fname,'w+');
    x  = vec_to_tfmvec(Geo.X(top_idx, 1), Geo); x = x(:);
    y  = vec_to_tfmvec(Geo.X(top_idx, 2), Geo); y = y(:);
% 	vecu = vec_to_tfmvec([u(top_idx, 1), u(top_idx, 2)], Geo);
    vecux = vec_to_tfmvec(u(top_idx, 1), Geo);
    vecuy = vec_to_tfmvec(u(top_idx, 2), Geo);
	
    vectx = vec_to_tfmvec(t(top_idx, 1), Geo);
    vecty = vec_to_tfmvec(t(top_idx, 2), Geo);
%     x  = Geo.X(top_idx, 1);
%     y  = Geo.X(top_idx, 2);
%     vecux = u(top_idx, 1);
%     vecuy = u(top_idx, 2);
%     vectx = t(top_idx, 1);
%     vecty = t(top_idx, 2);
    fprintf(ftfm,'%d %d %d %d %d %d \n', [x'; y'; vecux'; vecuy'; vectx'; vecty']);
    fclose(ftfm);
end