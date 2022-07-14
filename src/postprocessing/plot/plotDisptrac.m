function plotDisptrac(disptrac, label, fact)
	data = load(disptrac);
	x = data(:,1)*fact;
	y = data(:,2)*fact;
	ux = data(:,3)*fact;
	uy = data(:,4)*fact;
	tx = data(:,5)*fact;
	ty = data(:,6)*fact;
 	figure
 	subplot(1,2,1);
	p1 = quiver(x,y,ux,uy);
	set(p1,'AutoScale','on', 'AutoScaleFactor', 4)
	set(gcf,'position',[150,200,1600,800])
	title("Displacements")
	xlabel("x (m)")
	ylabel("y (m)")
	xlim([min(x) max(x)])
	ylim([min(y) max(y)])

	subplot(1,2,2)
	p2 = quiver(x,y,tx,ty);
	set(p2,'AutoScale','on', 'AutoScaleFactor', 4);
	title("Tractions")
	xlabel("x (m)")
	ylabel("y (m)")
	xlim([min(x) max(x)])
	ylim([min(y) max(y)])
	sgtitle(label) 
end