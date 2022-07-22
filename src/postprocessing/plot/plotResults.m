function plotResults(Geo, Mat, Set, Result)
% 	plotTractionsTFM(Geo, Set, Result)
	if Set.nano
		plotNano(Geo, Mat, Result);
	end
	if Geo.dim == 2
		femplot(Result.x(:,:,end), Geo, Mat, Set);
	end
	if Set.plot_stress && ~strcmpi(Mat.model,'elastic')
		if Geo.dim == 2
			plotStress2D(Geo, Mat, Set, Result);
		elseif Geo.dim == 3
			plotStress3D(Geo, Mat, Set, Result);
		end
	end
	if Set.plot_strain && ~strcmpi(Mat.model,'elastic')
		if Geo.dim == 2
			plotStrain2D(Geo, Mat, Set, Result);
		elseif Geo.dim == 3
			plotStrain3D(Geo, Mat, Set, Result);
		end
	end
end