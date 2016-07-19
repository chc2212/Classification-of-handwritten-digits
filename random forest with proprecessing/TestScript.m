% This script just for testing matlab command
%forest = RandomForest('training','treeNumber', 1);
RandomForest('validation', 'k-fold', 10);



% a = trainingDataset(:,[2 3]);
% max(a.(2))

% mean([2,3,4,5])
%FestureWeight(trainingDataset)

% a = [0.2,0.44,0.1,0.12,0.7,0.3,0.13];
% [a, index] = sort(a, 'descend');
% a = a(1:floor(0.8*length(a)));


%rng(1);
% treeSeeds = randperm(100000, 100)

% a = randi(1000,100,1)


% a = 1:10;
% a = reshape(a, [10,1])


% m=28;
% pos = 1;%randi(m,1,1);
%     fIdxStart = (pos-1)*m+1;
%     fIdxEnd = pos*m;
%     idx = fIdxStart:fIdxEnd;

% [M, F, C] = mode([9,9,23,23,3]);
% p = cell2mat(C);
% if find(p==21)
%     disp('aa')
%     
% end

%forest = RandomForest('training','treeNumber', 10);


% a = [0 0 0 0 0 0 0 0 0 0]
% a(1) = a(1) +1
% a(1) = a(1) +1



% s = 10;
%
% a = randperm(s,5)
% b = 1:s
% %b(a) = []
% cc = double(ismember(b,1))
% if cc == 1
%     disp('aa')
% end
% cc = 


% rng(5)
% randperm(10,3)
% randi([1 10],1,4)
% rng(5)
% randperm(10,3)
% randi([1 10],1,4)



% aa = 'log2(M+1)';
% 
% switch aa
%     case 'log2(M+1)'
%        disp('log2(M+1)')
%        break;
%     otherwise
%         disp('other value')
%        break;
% end



%{
rng(5)
s = rng;
A = randi(10,3,3)
A = randi(10,3,3)
rng(s);
A = randi(10,3,3)
rng(5);
A = randi(10,3,3)
%}