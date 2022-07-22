clc; close all; clear;
addpath(genpath('src'))

% [Geo, Mat, Set] = harm_hk_3d;
[Geo, Mat, Set] = nanoFit;
% [Geo, Mat, Set] = nano_fmx_3d;				% OK
% [Geo, Mat, Set] = dipole_3d;
% [Geo, Mat, Set] = pole_3d;

[Result, Geo, Mat, Set] = runTFM(Geo, Mat, Set);
% plotTractionsTFM(Geo, Set, Result)

% [Geo, Mat, Set] = pole_3d;
% Set.Boussinesq = true;
% [Result, Geo, Mat, Set] = runTFM(Geo, Mat, Set);
% plotTractionsTFM(Geo, Set, Result)

