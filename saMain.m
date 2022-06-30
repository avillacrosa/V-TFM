clc; close all; clear;
addpath(genpath('src'))

% [Geo, Mat, Set] = hk_t_2d;				% OK
% [Geo, Mat, Set] = hk_u_2d;				% OK

% [Geo, Mat, Set] = nh_t_2d;				% OK
% [Geo, Mat, Set] = nh_u_2d;				% OK

% [Geo, Mat, Set] = mx_hk_relax_2d;			% OK
% [Geo, Mat, Set] = mx_hk_flow_2d;			% OK

% [Geo, Mat, Set] = mx_nh_flow_2d;			% OK
% [Geo, Mat, Set] = mx_nh_relax_2d;			% OK

% [Geo, Mat, Set] = mx_ve_relax_2d;			% OK
% [Geo, Mat, Set] = mx_ve_flow_2d;			% OK

% [Geo, Mat, Set] = sls_nh_relax_2d;		% OK
% [Geo, Mat, Set] = sls_nh_flow_2d;			% OK

% [Geo, Mat, Set] = sls_nh_relax_3d;		% OK

% [Geo, Mat, Set] = fmx_hk_relax_2d;		% OK
% [Geo, Mat, Set] = fmx_hk_flow_2d;			% OK

% [Geo, Mat, Set] = nh_u_2d;				% OK
[Geo, Mat, Set] = nano_hk_2d;				% OK
% [Geo, Mat, Set] = nano_hk_3d;				% OK

% [Geo, Mat, Set] = nano_fmx_3d;				% OK

Result = runTFM(Geo, Mat, Set);
hold off
figure
plot(Result.uz, Result.Tz)
xlabel('u')
ylabel('T')

