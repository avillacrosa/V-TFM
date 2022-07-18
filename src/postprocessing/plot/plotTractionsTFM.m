function plotTractionsTFM(Geo, Set, Result)
	% Create file name variable
	filename = fullfile(Set.DirOutput, 'tractions_t.gif');
% 	% Plotting with no color to set axis limits
% 	quiver(x,y,z,'Color','none');
	% Plotting the first iteration
	tracts = Result.t;
	[~, top_idx] = ext_z(0, Geo);
	Xx = vec_to_grid(Geo.X(top_idx,1), Geo);
	Xy = vec_to_grid(Geo.X(top_idx,2), Geo);

	f = figure;
	q = quiver(Xx,Xy,vec_to_grid(tracts(top_idx,1,1), Geo),vec_to_grid(tracts(top_idx,2,1), Geo),'b');
	set(q,'AutoScale','on', 'AutoScaleFactor', 2);
	xlabel("x (m)")
	ylabel("y (m)")
	xlim([min(Geo.X(top_idx,1)) max(Geo.X(top_idx,1))])
	ylim([min(Geo.X(top_idx,2)) max(Geo.X(top_idx,2))])
	colormap(f,hot);
	t = 0;
	% Iterating through the length of the time array
	for k = 1:(Set.time_incr)
    	% Updating the line
    	q.UData = vec_to_grid(tracts(top_idx,1,k), Geo);
    	q.VData = vec_to_grid(tracts(top_idx,2,k), Geo);
		
    	% Updating the title
    	title(sprintf('Tractions (t=%0.2e s)', t));
    	% Delay
    	pause(1)
    	% Saving the figure
    	frame = getframe(gcf);
    	im = frame2im(frame);
    	[imind,cm] = rgb2ind(im,256);
		
		if k == 1
			imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',0.1);
		else
			imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime',0.1);
		end
		t = t + Set.dt;
	end
end