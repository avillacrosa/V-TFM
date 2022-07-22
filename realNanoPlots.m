clc; close all; clear
addpath(genpath('src'));
models = ["maxwell", "gmaxwell"];
elastics = ["hookean", "neohookean"];

expFile = 'C:\Users\avill\OneDrive - TU Eindhoven\0. Data\CardioBursts\Nanoindentation\20220207_PAA_15kPa\matrix_scan01\20220207_PAA_15kPa S-1 X-1 Y-1 I-1.txt';

eta = 1;
for m = 1:length(models)
	for e = 1:length(elastics)
		[Geo, Mat, Set] = nanoFit(expFile);
		Mat.model = models(m);
		Mat.elast = elastics(e);
		switch Mat.model
			case 'maxwell'
				Mat.c      = [Mat.E eta];
			case 'gmaxwell'
				Mat.c      = [Mat.E/2 eta];
				Mat.cexp   = [0 1];
		end
		Set.name = sprintf("nano_%s_%s", Mat.model, Mat.elast);
		[Result, Geo, Mat, Set] = runTFM(Geo, Mat, Set);
	end
end