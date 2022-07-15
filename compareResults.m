clc; close all; clear;
myDisptracF = 'C:\Users\avill\Documents\MyCodes\V-TFM\output\tfm_test\TFM';
shrDisptracF = 'C:\Users\avill\Documents\MyCodes\V-TFM\data\TEST\PIV';
for t = 1:10
	mine = fullfile(myDisptracF, sprintf("DISPTRAC_%02i.txt",t-1));
	theirs = fullfile(shrDisptracF, sprintf("DISPTRAC__TEST_%02i.txt",t));
	plotDisptrac(theirs, 'Shrine', 1);
	plotDisptrac(mine, 'Adaptation', 1);
% 	close all;
	return
end