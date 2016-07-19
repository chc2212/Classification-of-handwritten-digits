function idx = FeatureSelection(M, numOfSelFtr)
global randomSeedSwitch;
switch numOfSelFtr
    case 'log2(M+1)'
       % fix(down), floor(down), round(near), ceil(up)
       m = round(log2(M+1));   % number of features for tree
    case 'sqrt(M)'
       m = round(sqrt(M));
    otherwise
       m = M;
end

% m = round(log2(M+1));
%m = M;

% three way for random features
% 1: may have repeat features(column)
% idx = randi([1 M],1,m);  % selected features' index, from index 2 to M, NOT include label column
% 2: without repetition
if randomSeedSwitch == 1
    rng(treeSeeds(treeIdx)); 
end   
idx = randperm(M, m);
% 3: 28*28
%     rng(treeSeeds(treeIdx));
%     pos = randi(m,1,1);
%     fIdxStart = (pos-1)*m+1;
%     fIdxEnd = pos*m;
%     idx = fIdxStart:fIdxEnd;
% 4: all features