% Script for vectorizing multiple files

myDir = 'G:\cBCI\cBCI_Analytics\AllNeural';
myFiles = dir(fullfile(myDir, '*.mat'));

powerVector = zeros(1176876,10);
coherenceVector = zeros(27336,10); 


for i = 1:700
    baseFileName = myFiles(i).name;
    cellName = strsplit(baseFileName, '_');
   
    if strcmp(baseFileName,'AllNeural_005_005.mat')
        continue;
    elseif strcmp(baseFileName,'AllNeural_005_0005.mat')
        continue;

    elseif any([4,82] == str2double(cellName(2)))
        
        fprintf(1, 'Now reading %s\n', baseFileName);
        load(baseFileName);
        
        powerND = NeuralData.Power;
        coherenceND = NeuralData.Coherence;
        currentFileNum = str2double(cellName{1,3}(1:2));
        
        powerVector = vectorizePower(powerND, currentFileNum, powerVector);
        coherenceVector = vectorizeCoherence(coherenceND, currentFileNum, coherenceVector);
        
        
        % statement checks if it is the 10th file of a set
        if currentFileNum == 10
            
            fileToSave = strcat('powerVector_',cellName{1,2});
            fileToSave2 = strcat('coherenceVector_', cellName{1,2});
            save(fileToSave,'powerVector');
            save(fileToSave2,'coherenceVector');
            
            removeVars = {'cellName', 'NeuralData', 'coherenceND','powerND',...
                'powerVector', 'coherenceVector'};
            clear(removeVars{:});
            
            powerVector = zeros(1176876,10);
            coherenceVector = zeros(27336,10);
        end
    end
end


function [powerVector] = vectorizePower(powerND, currentFileNum, powerVector)

        power = squeeze(mean(powerND, 1));
        pVector = [];
        for j = 1:68
            for k = 1:27
                pVector = [pVector; power(k,:,j)']; %#ok<AGROW>
            end
        end
        powerVector(:,currentFileNum) = pVector;
            
end

function [coherenceVector] = vectorizeCoherence(coherenceND, currentFileNum, coherenceVector)
        
    coherence = squeeze(mean(coherenceND, 1));
    cVector = [];
    for l = 1:3
        for m = 1:4
            a = squeeze(coherence(l,m,:,:));
            I = true(size(a));
            b = a(tril(I, -1));
            cVector = [cVector; b]; %#ok<AGROW>
        end
    end
    coherenceVector(:,currentFileNum) = cVector;
end