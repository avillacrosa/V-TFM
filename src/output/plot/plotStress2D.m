function plotStress2D(Geo, Mat, Set, Result, symbol)
	if (~exist('symbol', 'var'))
		symbol = 'o';
	end
	figure
	hold on
	s_t = vecnorm(Result.s(:,:,:), 2, 2);
	plot(Result.time, reshape(s_t(1,:,:), size(Result.time)), symbol);
	plot(Result.time, reshape(s_t(2,:,:), size(Result.time)), symbol);
	plot(Result.time, reshape(s_t(3,:,:), size(Result.time)), symbol);
	lgdStr = ["\sigma_{xx}","\sigma_{yy}", "\sigma_{yx}"];
	ylabel("\sigma", "FontSize", 14);
	xlabel("t(s)", "FontSize", 12)
% 	if strcmpi(Mat.model, 'maxwell')
% 		stress_1d = max(abs(Result.strain(:,1,1)))*Mat.E*exp(-Mat.E*Result.time/Mat.visco);
% 		lgdStr(end+1) = "1D Solution";
% 		plot(Result.time, stress_1d);
% 	end
	lgd = legend(lgdStr);
	lgd.FontSize = 10;
	lgd.Location = 'northeast';
end