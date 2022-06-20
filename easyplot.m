function easyplot(k, x_t, Geo, Mat, Set)
	x_k = ref_nvec(x_t(:,k), Geo.n_nodes, Geo.dim);
	femplot(x_k, Geo, Mat, Set);
	hold on;
	xs = getSpherex(Set.r0, Set.r);
	plot(xs(:,1), xs(:,2));
	fixR = logical(Geo.fixR(:,k));
	plot(x_k(fixR,1), x_k(fixR,2), 'o');
	x0=400;
	y0=10;
	width=1000;
	height=1000;
	set(gcf,'position',[x0,y0,width,height])
% 	close all;
end