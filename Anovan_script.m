
myDir = 'DATA';
myFiles = dir(fullfile(myDir, '*.mat'));

[label, text] = xlsread('Labels','A:B');


% create labels

subjectNumberLabel = zeros(size(text,1),1);

for i = 1:size(text,1)

    labelSplitString = strsplit(text{i},'.');

    subjectNumberLabel(i) = str2double(labelSplitString{1});   

end

anovaMatrix = [];

for i = 1:length(myFiles)

    baseFileName = myFiles(i).name;

    cellName = strsplit(baseFileName, '_');

    cellName_1 = cellName{1};
    
    if strcmp(cellName_1,'coherenceVector')
        
        currentFile = load(baseFileName);

        addMatrix = currentFile.coherenceVector;

        anovaMatrix = cat(1,anovaMatrix, addMatrix'); %#ok<AGROW> 

    end

end

% N-way Anova

subject = subjectNumberLabel;
sessionLabel = label;
result = zeros(295,3);
stdVector = std(anovaMatrix, 0,2);
anovaMatrix = anovaMatrix.*(stdVector.^-1);
for i = 1:size(anovaMatrix,2)
    stats = anovan(anovaMatrix(:,i),{subject, sessionLabel},'model','interaction','varnames',{'subject','learningSession'},'sstype',1,'display','off');
    result(i,:) = stats';
    close all;
end
save('CoherenceResult2.mat','result')

