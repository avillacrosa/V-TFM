clc; close all; clear;
addpath(genpath('src'))

% [Geo, Mat, Set] = hk_t_2d;				% OK
% [Geo, Mat, Set] = hk_u_2d;				% OK

[Geo, Mat, Set] = mx_hk_flow_2d;			% BAD
% [Geo, Mat, Set] = mx_hk_relax_2d;			% BAD

% [Geo, Mat, Set] = mx_nh_flow_2d;			% OK
% [Geo, Mat, Set] = mx_nh_relax_2d;			% OK

% [Geo, Mat, Set] = nh_t_2d;				% OK
% [Geo, Mat, Set] = nh_u_2d;				% OK

% [Geo, Mat, Set] = mx_ve_relax_2d;			% OK
% [Geo, Mat, Set] = mx_ve_flow_2d;			% OK

% [Geo, Mat, Set] = sls_nh_relax_2d;		% OK
% [Geo, Mat, Set] = sls_nh_flow_2d;			% OK

% [Geo, Mat, Set] = sls_nh_relax_3d; 
% [Geo, Mat, Set] = sls_nh_flow_3d; 

Result = runTFM(Geo, Mat, Set);