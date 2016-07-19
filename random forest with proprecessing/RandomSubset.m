
% get subset of samples for constructing tree
% because select iob selection with relacement, 
% so the sum of iobSubset and oobSubset will be bigger than number of samples
function [iobSubset iobIdx oobSubset oobIdx] = RandomSubset(samples, seed, weight)
global randomSeedSwitch;

sizeOfSamples = size(samples,1);

% method one
% random size of subset 
%subSize = floor(rand(1)*sizeOfSamples);  % size of subset

% method two
% about 2/3 of sample size
subSize = floor(sizeOfSamples*2/3);     % size of bootstrap dataset for training

% randomly select index for training set

if randomSeedSwitch == 1
    rng(seed);
end


if max(weight)-min(weight) ==0
    %iobIdx = randi([1 sizeOfSamples],1,subSize);   % with-replacement (may pickup same sample)
    iobIdx = randperm(sizeOfSamples, subSize);     % without replacement
else
    % weight
    %weight = weight(iobIdx);
    
    [weight widx] = sort(weight);
    sr = floor(0.8*sizeOfSamples);
    %iobIdx = randi([1 sr],1,subSize);
    iobIdx = randperm(sr, subSize);
    iobIdx = widx(iobIdx);
    
end


iobSubset = samples(iobIdx,:);

oobIdx = 1:sizeOfSamples;
oobIdx(iobIdx) = [];
%oobIdx = reshape(oobIdx, [length(oobIdx),1]);
oobSubset = samples(oobIdx,:);




%samples(idx,:) = [];
%oobset = samples;   % out-of-bag samples, the number of this may bigger then 1/3 of original samples

%subset = table();
%subset = [subset;samples(1,:)];
%subset = [subset;samples(3,:)];
%subset = [subset;samples(5,:)];