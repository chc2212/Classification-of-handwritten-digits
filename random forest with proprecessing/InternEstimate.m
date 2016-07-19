% This method is depatched
function oobe = InternEstimate(treeNodes, oobset)

numOfErr = 0;
numOfOOB = size(oobset,1);

% for each out-of-bag sample
for i=1:numOfOOB

    oobsample = oobset(i,:);
    %oobsample.Properties.VariableNames

    targetLabel = oobsample.(1);
    predictLabel = PredictLabel(treeNodes, oobsample(:,2:width(sample)));
    predictLabelMode = mode(predictLabel); % mode, if not only one value, select the samllest one
    
    if targetLabel~=predictLabelMode
        numOfErr=numOfErr+1;
    end 
end

oobe = numOfErr/numOfOOB;

