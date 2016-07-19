function label = TestRandomForest(dataset)
%global testingDataset;
global forest;

%dataset = testingDataset;
sizeOfDataset = height(dataset);

results = [];

% for each testing sample
for sampleIdx=1:sizeOfDataset
    sample = dataset(sampleIdx,:);
    
    predictLabel = [];
    
    % for each tree
    for treeIdx=1:length(forest)
        tree = forest(treeIdx);
        treeNodes = tree.treeNodes;
        predictLabel = [predictLabel;PredictLabel(treeNodes, sample(:,2:width(sample)))];
    end
       
    predictLabel = mode(predictLabel);
  
    results = [results;predictLabel];
end

label = array2table(results);
writetable(label,'testLabel.csv');

