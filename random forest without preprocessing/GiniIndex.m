% calculate gini index
function gini = GiniIndex(targets)

targetLabels = unique(targets);    % target labels
k = size(targetLabels,1);           % number of target labels
totalSamples = size(targets,1);     % total number of samples for target

gini = 0;
for i=1:k
    nst = numel(find(targets==targetLabels(i)));    % number of specific target
    gini = gini + (nst/totalSamples)^2;
end
gini = 1 - gini;

%% time-consuming
%{
totalSamples = length(targets);     % total number of samples for target
numOfLabel = [0 0 0 0 0 0 0 0 0 0];
for tidx=1:totalSamples
    %curlabel: current label(0..9) in sample
    % current label index(0..9) for (1..10) array
    numOfLabel(targets(tidx)+1) = numOfLabel(targets(tidx)+1) + 1;
end

gini = 0;
for lidx=1:length(numOfLabel) 
    if numOfLabel(lidx) == 0
        continue;
    end    
    gini = gini + (numOfLabel(lidx)/totalSamples)^2;
end
gini = 1 - gini;
%}