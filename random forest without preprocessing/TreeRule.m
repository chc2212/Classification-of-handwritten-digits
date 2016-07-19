function TreeRule(Node, branch) % from leafNode
global treeNodes;

     if Node.parentNode == 0
         fprintf('IF ');
     else

        if Node.branch == 1
            TreeRule(treeNodes(Node.parentNode),1);
        elseif Node.branch == 2
            TreeRule(treeNodes(Node.parentNode),2);
        end     
     end
      
    if Node.isLeaf == 1
        fprintf(' THEN label = ');
        fprintf('%d ', Node.label);
        fprintf('\n');

    else
        if Node.parentNode == 0
        else
            fprintf(' AND ');
        end
        if branch == 1
             fprintf('%s<=%.2f', Node.chosedFeature, Node.splitPosition);
        elseif branch == 2
             fprintf('%s>%.2f', Node.chosedFeature, Node.splitPosition);
        end
             
    end

