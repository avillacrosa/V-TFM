function [E, r, data] = readNanoFile(expFile)
	fileID = fopen(expFile, 'r');
	line = fgetl(fileID);
	readingData = false;
	data = zeros(0,6);
	while ischar(line)
    	line = fgetl(fileID); % I LOVE MATLAB!
		if line ~= -1
			if readingData
				data(end+1,:) = sscanf(line, '%f');
			end
			if contains(line, 'E[eff]')
				young = regexp(line,'\d+\.?\d*','match');
				E = str2double(young{1});
			end
			if contains(line, 'Tip radius')
				radius = regexp(line,'\d+\.?\d*','match');
				r = str2double(radius{1})*10^-6;
			end
			if contains(line, 'Time') && contains(line, 'Load') && contains(line, 'Indentation')
				readingData = true;
			end
		end
	end
end