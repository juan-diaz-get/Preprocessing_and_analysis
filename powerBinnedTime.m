% Plots power with time binned

load('powerResult2.mat')
load('headmodel_68reg.mat')

Brain_regions = regions;
powerLearning = result(:,2);
powerLearning(powerLearning > 0.05) = 0;
powerLearning = reshape(powerLearning,68,27,641);

figure;
% frequency range index
coher_index = {1:4; 5:11; 12:27};
scMatrix = zeros(5,68);
for i = 1:68
    for j = 1:5
        if j == 5
            data = squeeze(powerLearning(i,coher_index{3},((j-1)*128 + 1):(128*j + 1)));
        else
            data = squeeze(powerLearning(i,coher_index{3},((j-1)*128 + 1):(128*j)));
        end
        scMatrix(j,i) = nnz(data);
    end
end

im = imagesc(scMatrix');
xticks(1:5)
yticks(1:68)
%xticklabels(Brain_regions)
%xtickangle(ax2,60)
yticklabels(Brain_regions)
colorbar
grid on
title(['Binned Power Result for brain regions (frequency 4 - 7 Hz)'])


