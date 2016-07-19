% improve
% 1. add cross-validation
% 2. add statistical 


% Main entrance for this project
% 1. Do not just run this script, it may be a time-consuming process and
% includes duplicate process
% 2. To run this program by pasting command lines in command window
% 3. Try to custom parameters and minitor the changes in the workspace
% 4. For each command line:
%       a. first parameter is command name, which specifies working process
%       b. following parameters are key/value pairs for this command
%           i.e. RandomForest('load_traning_dataset', 'size', 1000);
%                               command name            key  value


%% quick load
[randomSeed treeNumber numOfSelFtr trainingDataset] = RandomForest('quick_load');



%% initial key parameters for random forest

% initial parameters
[randomSeed treeNumber numOfSelFtr] = RandomForest('initial');

% initial with specific parameters
[randomSeed treeNumber numOfSelFtr] = RandomForest('initial',...
                'randomSeed', 5,...
                'treeNumber', 100,...
                'numOfSelFtr', '');

[randomSeed treeNumber numOfSelFtr] = RandomForest('initial',...
                'randomSeed', 5,...
                'treeNumber', 10,...
                'numOfSelFtr', 'log2(M+1)');

[randomSeed treeNumber numOfSelFtr] = RandomForest('initial',...
    'randomSeed', 9,...
    'treeNumber', 100,...
    'numOfSelFtr', 'sqrt(M)');


%% dataset preparation

% load all training data
trainingDataset = RandomForest('load_traning_dataset');

% load parts of training data
trainingDataset = RandomForest('load_traning_dataset', 'size', 5000);

% load all testing data
testingDataset = RandomForest('load_testing_dataset');

% load parts of testing data
testingDataset = RandomForest('load_testing_dataset', 'size',5000);

%% validation configuration process

RandomForest('validation', 'k-fold', 10);

RandomForest('validation', 'leave-one-out');


%% training process

% conduct training, default tree number is 50
forest = RandomForest('training');

% conduct training with specific tree number
forest = RandomForest('training','treeNumber', 2);

%% evaluating process
% trained forest is required, by which need use 'training' command first

% conduct out-of-bag evaluating for whole data
oobe = RandomForest('oob_evaluate');

% conduct out-of-bag evaluating with specific range
oobe = RandomForest('oob_evaluate','range',1:1000);

%% testing process
% 1. testing dataset required, by which need use 'load_testing_dataset' command
% 2. trained forest is required, by which need use 'training' command

% conduct tesing for whole testing dataset
label = RandomForest('testing');

% conduct training with specific range
label = RandomForest('testing','range',1:10);

