function [u, fix] = buildDirichletNano(Geo, Mat, Set)
	u = Geo.u; fix = Geo.fix;
	r = 0.2;
	r0 = [0.5, 1.01+r];
	v = -0.01;
	for k = 1:Set.time_incr
		r0(2) = r0(2)+v*k;
		x_k = Geo.X+u(:,:,k);
		fixR = vecnorm(x_k-r0, 2, 2)<r;
		fix(fixR,2)=true;

		x_k(fixR,2) = -sqrt(r^2-(x_k(fixR,1)-r0(1)).^2)+r0(2);
% 		u(fixR,2,k) = x_k(fixR,2)-Geo.X(fixR,:);
% 		femplot(Geo.X+u(:,:,k), Geo, Mat, Set);
		femplot(x_k, Geo, Mat, Set);
		hold on;
		xs = getSpherex(r0, r);
		plot(xs(:,1), xs(:,2));
		plot(x_k(fixR,1), x_k(fixR,2), 'o')
		;
		close all;
	end
end
