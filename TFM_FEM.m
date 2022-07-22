%Designed by Jelle van Orsouw, Vito Conte, Leon Hermans, and Janine Grolleman @UNIVERSITY of TECHNOLOGY Eindhoven for specific TFM usage (December 2019).
addpath('ShrineTFM'); addpath(genpath('src'));
close all; clear; clc;
%% LOADING files and variables
[p,n,emax,tmax,trypslist,settings]=load_database(); %%load files and variables
%% REGISTRATION (#1 or 3)
% registerImages(emax, n, p, settings, tmax, trypslist)
%% PIV (#2 or #3) 
% Standard PIV Settingsl
% pivRun(emax, n, p,  settings, tmax)
%% Postprocessing PIVs values
% pivFilter(emax, n, p,  settings, tmax)
%% COMPUTE TRACTION FORCES
% calcTractionF(emax, n, p,  settings, tmax)
% nzs = [5, 8, 10];
nzs = [6, 8, 10];

for nz = 1:length(nzs)
	settings.nz = nzs(nz);
	nzs(nz)
	calcTractionFVE(emax, n, p,  settings, tmax)
end
%% MASKING
% masking(emax, n, p, settings, tmax)
%% STRESS MICROSCOPY
% cd(p.STRESS)
% settings.c.emax=emax;
% settings.c.tmax=tmax; 
% StressMicroscopy(settings.c,n,p);