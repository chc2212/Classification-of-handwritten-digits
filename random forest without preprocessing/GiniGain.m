function ginigain = GiniGain(curVal, values, targets)

numOfSamples = size(values,1);
giniIdx = GiniIndex(targets);

% for left branch
idxOfLeft = find(values<=curVal);
numOfLeft = numel(idxOfLeft);   % number of values that small than and equel to current value

%values(idxOfLeft,:);
giniLeft = GiniIndex(targets(idxOfLeft,:));

       
%numOfRight = numel(find(values>curVal))
idxOfRight = find(values>curVal);
numOfRight = numel(idxOfRight);   % number of values that small than and equel to current value

%values(idxOfLeft,:);
giniRight = GiniIndex(targets(idxOfRight,:));


% calculate gini index
ginigain = giniIdx - ((numOfLeft/numOfSamples)*giniLeft + (numOfRight/numOfSamples)*giniRight);