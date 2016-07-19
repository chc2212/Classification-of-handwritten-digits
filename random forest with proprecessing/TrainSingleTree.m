function TrainSingleTree(dataset, vm_k)


global randomSeed;
global numOfSelFtr;



global treeNodeNo;
global treeNodes;
global treeNodesForPlot;

numOfTrees = treeNumber;  

% parameters for random forest
if nargin<2
    vm_k = '';
end


    treeNodeNo = 0;  % tree's node number
    treeNodesForPlot = 0;
    treeNodes = '';

    
    [subset sIdx] = RandomSubset(dataset, randomSeed);  % bootstrap dataset
    subsetForTraining = subset;
    
    labels = subsetForTraining(:,1);
    subsetForTraining(:,1) = [];
      
    % random select features to train this tree
   
    M = size(subsetForTraining,2);    % number of features
    %{
    switch numOfSelFtr
        case 'log2(M+1)'
           % fix(down), floor(down), round(near), ceil(up)
           m = round(log2(M+1));   % number of features for tree
        otherwise
           m = M/2;
    end
    %}
    % m = round(log2(M+1));
    m = 28;
    
    % three way for random features
    % 1: may have repeat features(column)
    % idx = randi([1 M],1,m);  % selected features' index, from index 2 to M, NOT include label column
    % 2: without repetition
    % rng(treeSeeds(treeIdx));
    % idx = randperm(M, m);
    % 3: 28*28
    rng(treeSeeds(treeIdx));
    pos = randi(m,1,1);
    fIdxStart = (pos-1)*m+1;
    fIdxEnd = pos*m;
    idx = fIdxStart:fIdxEnd;

    
    
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
    
    singleTree = struct('treeNo',treeIdx, ...
                  'treeNodes',treeNodes,...
                  'bootstrapIdx',sIdx...
                  );
    
%{           
    % draw single tree plot        
    treeplot(treeNodesForPlot); 
    [x,y] = treelayout(treeNodesForPlot);  
    for i=1:length(x)
        curNode = treeNodes(i);
        text(x(i),y(i), curNode.chosedFeature);      
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



