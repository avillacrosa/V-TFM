function plotDisptrac_u(disptrac)
	data = load(disptrac);
	x = data(:,1);
	y = data(:,2);
	ux = data(:,3);
	uy = data(:,4);
 	figure
	p1 = quiver(x,y,ux,uy);
	set(p1,'AutoScale','on', 'AutoScaleFactor', 4)
	set(gcf,'position',[150,200,1600,800])
	title("Displacements")
	xlabel("x (m)")
	ylabel("y (m)")
	xlim([min(x) max(x)])
	ylim([min(y) max(y)])
end