
function trees = TrainRandomForest(dataset, vm_k)

global randomSeedSwitch;
global randomSeed;
global numOfSelFtr;
global treeNumber;

randomSeedSwitch = 1;

%global trainingDataset;
global forest;

global treeNodeNo;
global treeNodes;
global treeNodesForPlot;

numOfTrees = treeNumber;  

% parameters for random forest
if nargin<2
    vm_k = '';
end

% sizeOfSamples = size(dataset,1);

trees = struct('treeNo',0, ...
                  'treeNodes','',...
                  'bootstrapIdx',[]...
                  );
                            
oobAcc = [];

dataSize = height(dataset);
% dIdx = [];
% for fi=2:width(dataset)
%     ftr = dataset.(fi);
%     if numel(find(ftr == 0)) == dataSize
%         dIdx = [dIdx;fi];
%     end
% end
% dataset(:,dIdx) = [];

% weight for each training data
W = [];
for td=1:dataSize
    W(td) = 1/dataSize;
end


if randomSeedSwitch == 1
    rng(randomSeed); 
end
% treeSeeds = randperm(1000, numOfTrees);
treeSeeds = randi(1000,numOfTrees,1);
tic;
% loop for all trees
for treeIdx=1:numOfTrees
    treeNodeNo = 0;  % tree's node number
    treeNodesForPlot = 0;
    treeNodes = '';
    

    [iosSubset iobIdx oobSubset oobIdx] = RandomSubset(dataset, treeSeeds(treeIdx), W);  % bootstrap dataset
    subsetForTraining = iosSubset;
    
    labels = subsetForTraining(:,1);
    subsetForTraining(:,1) = [];
      
    % random select features to train this tree
   
    M = size(subsetForTraining,2);    % number of features
    
    switch numOfSelFtr
        case 'log2(M+1)'
           % fix(down), floor(down), round(near), ceil(up)
           m = round(log2(M+1));   % number of features for tree
        case 'sqrt(M)'
           m = round(sqrt(M));
        otherwise
           m = M/2;
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
    

       
    subsetForTraining = subsetForTraining(:, idx);    % filter features for samples
    subsetForTraining = [labels subsetForTraining];
    treeNode = struct('nodeNo',treeNodeNo, ...
                  'chosedFeature','',...
                  'branch', 0,...   % 0: unset
                  'splitPosition', 0,...
                  'parentNode',0,...
                  'dataSet',subsetForTraining,...
                  'isLeaf',0,...
                  'label',''...
                  );
    treeNodes = treeNode;            

    GenerateTree(treeNode);
    
%{   
% draw single tree plot        
    treeplot(treeNodesForPlot); 
    [x,y] = treelayout(treeNodesForPlot);  
    for i=1:length(x)
        curNode = treeNodes(i);
        nodeLabel = sprintf('%s at %.2f',curNode.chosedFeature, curNode.splitPosition);
        text(x(i),y(i), nodeLabel);      
    end

       
% extract rules from single tree
    disp('The decision tree can also be expressed in rule format:');
    for r=1:length(treeNodes)
        curNode = treeNodes(r);
        if curNode.isLeaf == 1
            TreeRule(curNode); 
        end
    end
 %}
    
    accuracy = OOBAccuracy(treeNodes, oobSubset);
    oobAcc(treeIdx) = accuracy;
    % calculate oob accuracy
    
    singleTree = struct;
    singleTree.treeNo= treeIdx;
    singleTree.treeNodes = treeNodes;
    singleTree.bootstrapIdx = iobIdx;
    %singleTree.OOBAcc = accuracy;
%     singleTree = struct('treeNo',treeIdx, ...
%                   'treeNodes',treeNodes,...
%                   'bootstrapIdx',iobIdx...
%                   );
    
         
   
    trees(treeIdx) = singleTree;

    Z = 0;
    for td=1:dataSize
        sample = dataset(td,:);
        for ti=1:treeIdx
            curTree = trees(ti);             
            if numel(find(curTree.bootstrapIdx == td)) == 0
                W(td) = SampleWeight(trees,sample, td);
                break;
            end          
        end  
        Z = Z + W(td);       
    end
    for td=1:dataSize
        W(td) = W(td)/Z;
    end
    
    % intern estimate process
    % oobe = oobe + InternEstimate(treeNodes, oobset);
   
end % end of for loop


% construct forest

[oobAcc oocAccIdx] = sort(oobAcc, 'descend');
oocAccIdx = oocAccIdx(1:floor(0.8*length(oocAccIdx)));

forest = trees(oocAccIdx);

disp(['etime the ',num2str(i),'th loop time coset:',num2str(toc)]);
% oobe = oobe/numOfTrees

function weight = SampleWeight(trees, sample, sampleIdx)
numOfTrees = length(trees);
hi=0;
hoob=0;
for ti=1:numOfTrees
    curTree = trees(ti);             
    if numel(find(curTree.bootstrapIdx == sampleIdx)) == 0 % it's an oob tree        
        targetLabel = sample.(1);
        [M, F, C] = mode(PredictLabel(curTree.treeNodes, sample(:,2:width(sample))));
        if find(cell2mat(C)==targetLabel)
            hi=hi+1;
        end 
        hoob = hoob + 1;
    end
end
cxy = hi/hoob;
weight = 1 - cxy;


