clc; close all; clear
fpath = 'data/NiceNanoNoH.txt';
opath = 'data/NiceNano.gif';
nano = load(fpath);
nano = nano(nano(:,3) > 2,:);
figure; hold on
p = plot(nano(1,3), nano(1,2), 'r', 'linewidth', 2);
p2 = plot(nano(1,3), nano(1,2), 'b','linewidth', 2);
m = scatter(nano(1,3), nano(1,2),'filled','k');
xlabel("Indentation (nm)")
ylabel("Load (\muN)")
t = nano(1,1);
set(gcf,'Color',[1 1 1]);
set(gcf,'position',[0,0,500,500])
% set(gcf,'InvertHardCopy','Off');
xlim([0, max(nano(:,3))]);
ylim([min(nano(:,2)), max(nano(:,2))]);

p.XData = nano(1:1500,3);
p.YData = nano(1:1500,2);
p2.XData = nano(1500:end,3);
p2.YData = nano(1500:end,2);
tic
for k = 1:21:size(nano,1)
	if k > 1500
		p2.XData = nano(1500:k,3);
		p2.YData = nano(1500:k,2);
	else
		p.XData = nano(1:k,3);
		p.YData = nano(1:k,2);
	end

	m.XData = nano(k,3);
	m.YData = nano(k,2);
	title(sprintf('t = %0.2f s', t));
	frame = getframe(gcf);
	im = frame2im(frame);
	[imind,cm] = rgb2ind(im,256);
	
	if k == 1
		imwrite(imind,cm,opath,'gif', 'Loopcount',inf, 'DelayTime',0.000001);
	else
		imwrite(imind,cm,opath,'gif', 'WriteMode', 'append', 'DelayTime',0.000001);
	end
	t = nano(k,1);
end
toc