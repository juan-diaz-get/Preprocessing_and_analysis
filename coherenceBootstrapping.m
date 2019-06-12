% Bootstrapping for coherence

load('coherenceResult2.mat')
coherenceLearning = result(:,2);
coherenceLearning(coherenceLearning > 0.05) = 0;
coherenceLearning = reshape(coherenceLearning,3,4,2278);
result=[];
matrixStore = cell(1,12);
for i = 1:3
    for j = 1:4
%         subplot(3,4,((i-1)*4+j))
        vector = squeeze(coherenceLearning(i,j,:));
        A = tril(ones(68),-1);
        A(A~=0) = vector;
        A(A~=0)=1;
        
        A = A + A';
        matrixStore{(i-1)*4+j} = A;
        
        v = sum(A)';
        result = [result,v];
    end
end

count_arr = zeros(1,1000);
        
    for i = 1:12
        count = sum(result(:,i));
        for j = 1:1000
            count_point = 0;
            %for k = 1:count
                a = zeros(68, 68);    %x = randi(68); % shouldn't this be 67 becuase we will always have zeros in the diagonal and shouldn't replacement be an issue as well
                a(randperm(numel(a), count)) = 1;   %y = randi(68);
                count_point = sum(a(1,:));   %if y == 1
            %end
            count_arr(j) = count_point;
        end
        count_arr = sort(count_arr);
        threshold = count_arr(976);
        col = result(:,i);
        index = find(col >= threshold);
        t = zeros(68,1);
        t(index) = 1;
        matrixStore{i} = matrixStore{i}.*t;
    end

for i = 1:3
    for j = 1:4
        subplot(3,4,((i-1)*4+j))
        
        im = imagesc(matrixStore{(i-1)*4 + j});
        colorbar
        title(['Coherence Result for frequency ', num2str(i), ',time ', num2str(j)])
    end
end


