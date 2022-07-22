clc; close all; clear
bssnesq = 'data/SHRINE_RESULTS/PIV';
fem = 'output';
nzs = [2, 3];
err = zeros(length(nzs), 10, 2);
for z = 1:length(nzs)
	nz = nzs(z);
	for t = 1:10
		bssnesq_data = load(fullfile(bssnesq, sprintf('DISPTRAC__TEST_%02d.txt', t)));
		tx_bssnsq = bssnesq_data(:,5);
		ty_bssnsq = bssnesq_data(:,6);
		fem_data = load(fullfile(fem, sprintf('tfm_fem_nz%d', nz), 'TFM', sprintf('DISPTRAC_%02d.txt', t)));
		tx_fem = fem_data(:,5);
		ty_fem = fem_data(:,6);
		err(z,t,1) = mean(abs((tx_bssnsq - tx_fem)./tx_bssnsq));
		err(z,t,2) = mean(abs((ty_bssnsq - ty_fem)./ty_bssnsq));
	end
end


%% tx plot
figure; hold on
xlabel('time');
ylabel('error');
title('t_x')
for z = 1:length(nzs)
	nz = nzs(z);
	plot(0:9, err(z,:,1), 'DisplayName', sprintf("%d",nz))
end
legend()

figure; hold on
plot(nzs, mean(err(:,:,1),2))

%% ty plot