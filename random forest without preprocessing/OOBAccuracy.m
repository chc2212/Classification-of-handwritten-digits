function accuracy = OOBAccuracy(treeNodes, oobDataset)
sizeOfDataset = height(oobDataset);

numOfAcc = 0;
numOfOOB = sizeOfDataset;

for sampleIdx=1:sizeOfDataset
    sample = oobDataset(sampleIdx,:);
    
    predictLabel = PredictLabel(treeNodes, sample(:,2:width(sample)));

    if ~isempty(predictLabel)
        targetLabel = sample.(1);
        [M, F, C] = mode(predictLabel);
        predictLabel = cell2mat(C);
        if find(predictLabel==targetLabel)
            numOfAcc=numOfAcc+1;
        end       
    end
end

accuracy = numOfAcc/numOfOOB;