function oobe = OOBEvaluate(dataset)

global forest;

sizeOfDataset = height(dataset);

numOfErr = 0;
numOfOOB = 0;

% for each traning sample
for sampleIdx=1:sizeOfDataset
    sample = dataset(sampleIdx,:);
    
    predictLabel = [];
    % for each tree
    for treeIdx=1:length(forest)
        tree = forest(treeIdx);
        bootstrapIdx = tree.bootstrapIdx;
        
        isOOBClassifer = 1;
        % bootstrap include this sample, it's not a oob data, so pass it
        for idxi=1:length(bootstrapIdx)
            if bootstrapIdx(idxi) == sampleIdx
                isOOBClassifer = 0;
                break;
            end
        end
        
        if isOOBClassifer == 0
            continue;
        end
        
        % pridict process
        treeNodes = tree.treeNodes;
        
        predictLabel = [predictLabel;PredictLabel(treeNodes, sample(:,2:width(sample)))];
        
    end
    
    % don't find any classifer that doesn't include this sample
    if ~isempty(predictLabel)
        targetLabel = sample.(1);
        predictLabel = mode(predictLabel);

        if targetLabel~=predictLabel
            numOfErr=numOfErr+1;
        end
        numOfOOB = numOfOOB + 1;
    end
    
    
end

oobe = numOfErr/numOfOOB;


