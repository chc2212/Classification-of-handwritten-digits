function [maxGain splitFeatureIdx splitPosition] = MaxGiniGain(samples)

maxGain = -100;
splitFeatureIdx = -100;
splitPosition = -100;

targets = samples.label;

samples = samples(:, 2:size(samples,2));
%X = cell2mat(table2cell(X));
[numOfSamples numOfFeatures] = size(samples);
%numOfFeatures
% for each features
for i=1:numOfFeatures
    values = samples.(i);    % values for each features
    valueLabel = unique(values);
    numOfValueLabel = size(valueLabel,1);   % number of values
    
    % for each value of features
    for j=1:numOfValueLabel   
        curVal = valueLabel(j);
        if j<numOfValueLabel
            pos = (valueLabel(j) + valueLabel(j+1)) / 2;
        else
            pos = curVal;
        end
        
        ginigain = GiniGain(curVal, values, targets);
        if ginigain >= maxGain
            maxGain = ginigain;
            splitFeatureIdx = i;
            splitPosition = pos;
        end
        
    end
    
end


