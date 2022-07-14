function writeOut(c, Geo, Set, Result)
	if ~Set.output
		return
	end
    if Geo.dim == 3
        x = Result.x(:,:,c);
        u = Result.u(:,:,c);
        F = Result.F(:,:,c);
        T = Result.T(:,:,c); 
        t = Result.t(:,:,c);
        s = Result.s(:,:,c);
    	fname = fullfile(Set.VTKDirOutput,sprintf("fem_t%02i.vtk", c-1));
    	writeVTK(Geo, x, u, F, T, t, s, fname);
		for ti = 1:size(Result.u, 3)
%         	fname = fullfile(Set.TFMDir,sprintf("DISPTRAC_%02i.txt", c-1));
%         	writeVecTop([Geo.X(:,1), Geo.X(:,2), u, t], Geo, fname)
			fname = fullfile(Set.TFMDir,sprintf("DISPTRAC_%02i.txt", c-1));
        	writeDisptrac(u, t, Geo, fname)
%         	fname = fullfile(Set.TFMDirDisp,sprintf("u_t%02i.txt", c-1));
%         	writeVecTop(u, Geo, fname)
%         	fname = fullfile(Set.TFMDirTrac,sprintf("t_t%02i.txt", c-1));
%         	writeVecTop(t, Geo, fname)
		end
    end
end