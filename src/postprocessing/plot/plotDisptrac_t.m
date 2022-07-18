function plotDisptrac_t(disptrac)
	data = load(disptrac);
	x = data(:,1);
	y = data(:,2);
	tx = data(:,5);
	ty = data(:,6);
 	figure
	p2 = quiver(x,y,tx,ty);
	set(p2,'AutoScale','on', 'AutoScaleFactor', 4);
	title("Tractions")
	xlabel("x (m)")
	ylabel("y (m)")
	xlim([min(x) max(x)])
	ylim([min(y) max(y)])
end