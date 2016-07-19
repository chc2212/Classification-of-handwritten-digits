% Validation
function [vm] = Validation(dataset, vm_k, vm_v)
totalErrRate = 0;
dataSize = height(dataset);

switch vm_k
    case 'out-of-bag'
        return;
    case 'leave-one-out'
        for testdataIdx=1:dataSize
            trainset = dataset;
            trainset(testdataIdx,:) = [];
            forest = TrainRandomForest(trainset, vm_k);   
            errRate = Evaluate(forest, dataset(testdataIdx, :), vm_k);
            totalErrRate = totalErrRate+errRate;           
        end
        totalErrRate = totalErrRate/dataSize;
             
        vm = 'leave-one-out';      
        return;
    case 'k-fold'
        k = vm_v;
        numInEachFold = floor(dataSize/k);
            
        for kIdx=1:k
            startIdx = (kIdx-1)*numInEachFold+1;
            endIdx = kIdx*numInEachFold;
            testsetIdx = startIdx:endIdx;
            trainsetIdx = [1:dataSize]';
            trainsetIdx(testsetIdx,:) = [];
            forest = TrainRandomForest(dataset(trainsetIdx, :), vm_k);
            errRate = Evaluate(forest, dataset(testsetIdx, :), vm_k);
            totalErrRate = totalErrRate+errRate;            
        end
        totalErrRate = totalErrRate/k;
               
        vm = strcat(num2str(vm_v),'-fold');
        return;
    otherwise
        vm = 'not set';
        return; 
end


