function [varargout] = RandomForest(command, varargin)

% parameters for random forest
global trainingDataset;
global testingDataset;
global forest;
global randomSeed;
global treeNumber;
global numOfSelFtr;


if strcmp(command,'initial') == 1
    %% Initial
    % default value for key parameters
    randomSeed = 5;     % determine forest construcion
    treeNumber = 50;
    numOfSelFtr = 'log2(M+1)';
    
    nVarargs = length(varargin);
    for k = 1:2:nVarargs
        switch varargin{k}
            case 'randomSeed'
                % Random number seed
                % random seed provides enough randomness in the selection of records in the datasets.
                randomSeed = varargin{k+1};
            case 'treeNumber'
                % Number of trees
                treeNumber = varargin{k+1};
            case 'numOfSelFtr'
                % Number of selected features
                numOfSelFtr = varargin{k+1};
            otherwise
                disp('other value')
        end
    end
    
    varargout{1} = randomSeed;
    varargout{2} = treeNumber;
    varargout{3} = numOfSelFtr;


elseif strcmp(command,'load_traning_dataset') == 1
    %% Load Training Dataset
    %trainingDataset = readtable('train.csv');
    trainingDataset = readtable('train-5000.csv');

    trainingSize = height(trainingDataset); % default size for training size
    nVarargs = length(varargin);
    for k = 1:2:nVarargs
        switch varargin{k}
            case 'size'
                trainingSize = varargin{k+1};
                break;
            otherwise
                disp('other value')
                break;
        end
    end
    
    
    trainingDataset = trainingDataset(1:trainingSize,:);
    varargout{1} = trainingDataset;
    
elseif strcmp(command,'load_testing_dataset') == 1
    %% load testing dataset
    testingDataset = readtable('test.csv');
    testingSize = height(testingDataset); % default size for testing size
    nVarargs = length(varargin);
    for k = 1:2:nVarargs
        switch varargin{k}
            case 'size'
                testingSize = varargin{k+1};
                break;
            otherwise
                disp('other value')
                break;
        end
    end
    
    
    testingDataset = testingDataset(1:testingSize,:);
    varargout{1} = testingDataset;

elseif strcmp(command,'validation') == 1
    vm = '';
    %% validation
    nVarargs = length(varargin);
    if nVarargs == 2
        Validation(trainingDataset, varargin{1}, varargin{2});
    else
        Validation(trainingDataset, varargin{1});
    end
        
    
    %varargout{1} = vm;
elseif strcmp(command,'training') == 1
    if isempty('vm_k')
        disp('You need set a specific validation method\n');
        return;
    end
        
    %% training
    nVarargs = length(varargin);
    for k = 1:2:nVarargs
        switch varargin{k}
            case 'treeNumber'
                treeNumber = varargin{k+1};
            case 'validation'
                
                    
            case 'extractRule'
            otherwise
        end
      %fprintf('   %d\n', varargin{k})
    end
        
    forest = TrainRandomForest(trainingDataset);
    varargout{1} = forest;
    
elseif strcmp(command,'testing') == 1
    %% testing
    nVarargs = length(varargin);
    range = [1,height(testingDataset)];
    for k = 1:2:nVarargs
        switch varargin{k}
            case 'range'
                range = varargin{k+1};               
                break;
            otherwise
                
                disp('other value')
                break;
        end
      %fprintf('   %d\n', varargin{k})
    end
    label = TestRandomForest(testingDataset(range,:));
    varargout{1} = label;
    
elseif strcmp(command,'oob_evaluate') == 1
    %% out-of-bag evaluation
    nVarargs = length(varargin);
    range = [1:height(trainingDataset)];
    for k = 1:2:nVarargs
        switch varargin{k}
            case 'range'
                range = varargin{k+1};               
                break;
            otherwise
                
                disp('other value')
                break;
        end
      %fprintf('   %d\n', varargin{k})
    end
    oobe = OOBEvaluate(trainingDataset(range,:));
    
    varargout{1} = oobe;

elseif strcmp(command,'quick_load') == 1
    [randomSeed treeNumber numOfSelFtr] = RandomForest('initial',...
                'randomSeed', 10,...
                'treeNumber', 50,...
                'numOfSelFtr', 'log2(M+1)');
    trainingDataset = RandomForest('load_traning_dataset');

    varargout{1} = randomSeed;
    varargout{2} = treeNumber;
    varargout{3} = numOfSelFtr;
    varargout{4} = trainingDataset;
end
    


% load training dataset
% trainingDataset = readtable('train.csv');
% trainingDataset = trainingDataset(1:1000,:);

% conduct training process
% forest = TrainRandomForest(trainingDataset,50);

% conduct oob evaluate process
% OOBEvaluate(trainingDataset, forest);

% test-------------------
%{
testSample = trainingDataset(10,:);

predictLabel = [];
for treeIdx=1:length(forest)
    tree = forest(treeIdx);
    treeNodes = tree.treeNodes;
 
    predictLabel = [predictLabel;PredictLabel(treeNodes, testSample(:,2:width(sample)))];  
end
targetLabel = testSample.(1)
predictLabel = mode(predictLabel)
%}


% % load testing dataset
% testingDataset = readtable('test.csv');
% testingDataset = testingDataset(1:100,:);
% 
% % conduct testing process
% TestRandomForest(forest, testingDataset);
