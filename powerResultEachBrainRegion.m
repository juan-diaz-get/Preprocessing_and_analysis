% Power Results - Plots Frequency v Time for each brain region

load('powerResult2.mat')
powerLearning = result(:,2);
powerLearning(powerLearning > 0.05) = 1;
powerLearning = reshape(powerLearning,68,27,641);
figure;

for i = 1:36
    subplot(6,6,i)
    data = squeeze(powerLearning(i,:,:));
    im = imagesc(data);
    colorbar
    title(['Power Result for brain region ', num2str(i)])
end

figure;
for i = 37:68
    subplot(6,6,i-36)
    data = squeeze(powerLearning(i,:,:));
    im = imagesc(data);
    colorbar
    title(['Power Result for brain region ', num2str(i)])
end
