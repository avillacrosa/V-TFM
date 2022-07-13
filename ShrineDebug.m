clc; close all; clear
load('synthShrine')
addpath(genpath('src'));
[tx_t, ty_t] = shrineRunTFM(settings.tInt, settings.E(n.conditions.c2e(e),n.dates.d2e(e)),settings.nu,settings.d(e),settings.H,ux_t,uy_t, tmax(e), settings);
        