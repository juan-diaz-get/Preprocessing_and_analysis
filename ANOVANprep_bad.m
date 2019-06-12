% Example of how our intial script did not generalize well

myDir = 'G:\cBCI\cBCI_Analytics\AllNeural';
myFiles = dir(fullfile(myDir, '*.mat'));

count = 0;

powerVector_062 = zeros(1176876,10);
%for i = 1:length(myFiles) %735
for i = 1:700
    baseFileName = myFiles(i).name;
    cellName = strsplit(baseFileName, '_');
    if size(cellName, 2) == 2
        continue;
    elseif str2double(cellName(2)) < 2
        continue;
    elseif str2double(cellName(2)) > 106
        continue;
    elseif str2double(cellName(2)) == 4
        continue;
    elseif str2double(cellName(2)) == 12
        continue;
    elseif str2double(cellName(2)) == 14
        continue;
    elseif str2double(cellName(2)) == 19
        continue;
    elseif str2double(cellName(2)) == 21
        continue;
    elseif str2double(cellName(2)) == 22
        continue;
    elseif str2double(cellName(2)) == 48
        continue;
    elseif str2double(cellName(2)) == 51
        continue;
    elseif str2double(cellName(2)) == 57
        continue;
    elseif str2double(cellName(2)) == 58
        continue;
    elseif str2double(cellName(2)) == 65
        continue;
    elseif str2double(cellName(2)) == 68
        continue;
    elseif str2double(cellName(2)) == 75
        continue;
    elseif str2double(cellName(2)) == 84
        continue;
    elseif str2double(cellName(2)) == 85
        continue;
    elseif str2double(cellName(2)) == 92
        continue;
    elseif str2double(cellName(2)) == 93
        continue;
    elseif str2double(cellName(2)) == 105
        continue;
    elseif strcmp(baseFileName,'AllNeural_002_06.mat')
        continue;
    elseif strcmp(baseFileName,'AllNeural_022_05.mat')
        continue;
    elseif strlength(cellName(3)) > 6
        continue;
    elseif str2double(cellName(2)) == 62
        fprintf(1, 'Now reading %s\n', baseFileName);
        load(baseFileName);
        power = squeeze(mean(NeuralData.Power, 1));
        
        pVector = [];
        for j = 1:68
            for k = 1:27
                pVector = [pVector; power(k,:,j)']; %#ok<AGROW>
            end
        end
        count = count + 1;
        powerVector_062(:,count) = pVector;
        
        %coherence = squeeze(mean(NeuralData.Coherence, 1));
    end
end
save('powerVector_062.mat','powerVector_062');