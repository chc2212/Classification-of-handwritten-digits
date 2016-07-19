function errRate = Evaluate(forest, dataset, vm_k)

sizeOfDataset = size(dataset,1);

numOfErr = 0;

% for each traning sample
for sampleIdx=1:sizeOfDataset
    sample = dataset(sampleIdx,:);
    
    predictLabel = [];
    % for each tree
    for treeIdx=1:length(forest)
        tree = forest(treeIdx);
    
        % pridict process
        treeNodes = tree.treeNodes;
        
        % predictLabel = [predictLabel;PredictLabel(treeNodes, sample(:,2:width(sample)))];
        
        predict = PredictLabel(treeNodes, sample(:,2:size(sample,2)));
        [M, F, C] = mode(predict);
        predict = cell2mat(C);
        predictLabel = [predictLabel;predict];
        
    end
    
    % don't find any classifer that doesn't include this sample
    if ~isempty(predictLabel)
        targetLabel = sample(:,1);
        [M, F, C] = mode(predictLabel);
        predictLabel = cell2mat(C);
        if find(predictLabel==targetLabel)
        else
            numOfErr=numOfErr+1;
        end
    end
    
    
end

errRate = numOfErr/sizeOfDataset;
