function [processedDataset y] = Preprocessing(dataset)
dataset = table2cell(dataset);
dataset = cell2mat(dataset);
y = dataset(:,1);
dataset(:,1) = [];
X = dataset;

processedDataset = [];

for dataIdx=1:size(X,1)
    x = X(dataIdx,:);
    % reshape
    x = reshape(x, 28, 28)';
   
    % binarization
    x = Binarization(x);
    
    % denoising
    
    % crop
    x = Cropping(x);
    
    % show digit image
    imagesc(x);
    
    % feature extraction
    ftrVector = FeatureExtraction(x);
    processedDataset = [processedDataset;ftrVector];
    %processedDataset(dataIdx) = FeatureExtraction(data);    
end
processedDataset = [y processedDataset];