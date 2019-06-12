load('coherenceResult2.mat')
coherenceLearning = result(:,2);
coherenceLearning(coherenceLearning > 0.05) = 0;
coherenceLearning = reshape(coherenceLearning,3,4,2278);
for i = 1:3
    for j = 1:4
        subplot(3,4,((i-1)*4+j))
        vector = squeeze(coherenceLearning(i,j,:));
        A = tril(ones(68),-1);
        A(A~=0) = vector;
        A(A~=0)=1;
        
        im = imagesc(A);
        colorbar
        title(['Coherence Result for frequency ', num2str(i), ',time ', num2str(j)])
    end
end
