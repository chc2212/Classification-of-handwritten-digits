function GenerateTree(treeNode)

global treeNodesForPlot;
global treeNodes;
global treeNodeNo;
if isempty(treeNodeNo)
    treeNodeNo=0;
end
treeNodeNo = treeNodeNo + 1;
curNodeNo = treeNodeNo;

%samples = sampleForTree;

samples = treeNode.dataSet;
parentNode = treeNode.parentNode;
chosedFeature = treeNode.chosedFeature;
branch = treeNode.branch;
splitPosition = treeNode.splitPosition;
targets = samples.label;
isLeaf = 0;

treeNodesForPlot(curNodeNo) = parentNode;

% dNum = 0;
% for fi=2:width(samples)
%     ftr = samples.(fi);
%     if max(ftr) == 0;
%         dNum = dNum + 1;
%     end
% end

[maxGain splitFeatureIdx splitPosition] = MaxGiniGain(samples);

if width(samples)==1 || maxGain < 0.0001 || min(targets) == max(targets)%|| max(samples) == 0  % only label column left, it's a leaf node
    isLeaf = 1;
    curNode = struct('nodeNo',curNodeNo, ...
                  'chosedFeature','',...
                  'branch',0,...
                  'splitPosition', 0,...
                  'parentNode',parentNode,...
                  'dataSet', samples,...
                  'isLeaf',isLeaf,...
                  'label', targets...
                  );
              
              
    treeNodes(curNodeNo) = curNode; 
    return;
end


sampleOfSF = samples.(splitFeatureIdx+1);   % samples of split feature

chosedFeature = samples.Properties.VariableNames; 
chosedFeature = chosedFeature(splitFeatureIdx+1);

% current tree node
curNode = struct('nodeNo',curNodeNo, ...
                  'chosedFeature',chosedFeature,...
                  'branch', branch,...   % branch=2 for right node
                  'splitPosition', splitPosition,...
                  'parentNode',parentNode,...
                  'dataSet', samples,...
                  'isLeaf',isLeaf,...
                  'label', ''...
                  );
treeNodes(curNodeNo) = curNode;

samples(:,splitFeatureIdx+1) = [];  % delete splited feature column


% for left branch
idxLeft = find(sampleOfSF<=splitPosition);
sampleLeft = samples(idxLeft,:);

leftNode = struct('nodeNo',0, ...
                  'chosedFeature',chosedFeature,...
                  'branch', 1,...   % branch=1 for left node
                  'splitPosition', splitPosition,...
                  'parentNode',curNodeNo,...
                  'dataSet', sampleLeft,...
                  'isLeaf',0,...
                  'label', ''...
                  );

GenerateTree(leftNode);



% for right branch
idxRight = find(sampleOfSF>splitPosition);
sampleRight = samples(idxRight,:);

rightNode = struct('nodeNo',0, ...
                  'chosedFeature',chosedFeature,...
                  'branch', 2,...   % branch=2 for right node
                  'splitPosition', splitPosition,...
                  'parentNode',curNodeNo,...
                  'dataSet', sampleRight,...
                  'isLeaf',0,...
                  'label', ''...
                  );

GenerateTree(rightNode);




















