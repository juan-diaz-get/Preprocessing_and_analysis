% Bootstrappig for power p-values. In process

load('powerResult2.mat')
load('headmodel_68reg.mat')

Brain_regions = regions;
powerLearning = result(:,2);
powerLearning(powerLearning > 0.05) = 0;
powerLearning = reshape(powerLearning,68,27,641);

coher_index = {1:4; 5:11; 12:27};
scMatrix = zeros(5,68);
matrixStore2 = cell(1,15);

count_point_list = zeros(1000,3);
threshlist = zeros(3,1);
matrixStore2 = cell(1,15);

for i = 1:3
    for j = 1:5
        if j == 5
            B = zeros(68,129);
            data = powerLearning(:,coher_index{i},((j-1)*128 + 1):(128*j + 1));
            for k = 1:68
                for l = 1:129
                    B(k,l) = nnz(data(k,:,l));
                end
                matrixStore2{j + (i-1)*5} = B;
            end    
        else
            B = zeros(68,128);
            data = powerLearning(:,coher_index{i},((j-1)*128 + 1):(128*j));
            for k = 1:68
                for l = 1:128
                    B(k,l) = nnz(data(k,:,l));
                end
                matrixStore2{j + (i-1)*5} = B;
            end
        end
        %scMatrix(j,i) = nnz(data);
    end
end

for h = 1:3
    for i = 1:1000
        count_point_bins = [1 5 10 15 20];
        while ~(all(abs(count_point_bins - repmat(mean(count_point_bins),1,5)) <= (1 + (h-1)))) 
        B = zeros(68,641);
        data = powerLearning(:,coher_index{h},:);
        num_nonz = nnz(data);
    
        B(randperm(numel(B), num_nonz)) = 1;
        count_point_bins = [sum(B(1,1:128)), sum(B(1,129:256)), sum(B(1,257:384)), sum(B(1,385:512)), sum(B(1,513:641))]; 
        end
        count_point_list(i,h) = round(mean(count_point_bins));
    end
    sort_list = sort(count_point_list(:,h));
    threshlist(h,1) = sort_list(976);
end

for m = 1:3
    for n = 1:5
        matrix2 = matrixStore2{(m-1)*5+n};
        col = sum(matrix2')';
        index = find(col >= threshlist(m));
        t = zeros(68,1);
        t(index) = 1;
        matrixStore2{(m-1)*5+n} = matrixStore2{(m-1)*5+n}.*t;
    end
end

