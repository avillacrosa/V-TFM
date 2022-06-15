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

[Geo, Mat, Set] = mx_hk_relax_2d;			% OK
% [GeoF, MatF, SetF] = fmx_hk_relax_2d;		% OK
Result = runTFM(Geo, Mat, Set);

% ResultF = runTFM(GeoF, MatF, SetF);
% 
% [GeoH, MatH, SetH] = mx_hk_relax_2d;	
% ResultH = runTFM(GeoH, MatH, SetH);
% close all
% plotStress2D(GeoH, MatH, SetH, ResultH);
% plotStress2D(GeoF, MatF, SetF, ResultF, 'x');

