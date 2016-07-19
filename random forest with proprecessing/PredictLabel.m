function label = PredictLabel(treeNodes, sample)

node = treeNodes(1);    % root node

while(1)   
    if node.isLeaf == 1
        label = node.label;
        break;
    end
        
    %value = FtrValByNode(treeNodes,node, sample); % value in sample
    value = sample(node.chosedFeature+1);
    if value<=node.splitPosition
        % left branch
        node = SubNode(treeNodes,node, 1);     
    else
        % right branch
        node = SubNode(treeNodes,node, 2);  
    end  
    
end

% to do fix
% Based on the feature of node, get the value in oobsample of this feature
function oobvalue = FtrValByNode(treeNodes,node, oobsample)
oobFtrs = oobsample.Properties.VariableNames; 
[bool,index] = ismember(oobFtrs, node.chosedFeature);
oobvalue = oobsample.(find(index));

% This way can work, but it's time-comsuming.
% cafs=strfind(oobsample.Properties.VariableNames,node.chosedFeature);  % cell array with 1 for included string
% fIdx = find(not(cellfun('isempty', cafs)));     % get index for that included string
% oobvalue = cell2mat(table2cell(oobsample(1,fIdx)));


function node = SubNode(treeNodes, parentNode, branch)

% for each node 
for nodeIdx=1:length(treeNodes)
    curNode = treeNodes(nodeIdx);
    
    % current node is the subnode of parent node
    if curNode.parentNode == parentNode.nodeNo
        node = curNode;
        
        if branch == curNode.branch
            break;
        end              
    end 
end


