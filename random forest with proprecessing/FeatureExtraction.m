function ftrVector = FeatureExtraction(x)


%% total dim

% circle feature (dim:1)
% value: 0,1
% has not circle: 0,1,2,3,4,5,6,7,9
% has circle:0,2,3,4,6,8,9
isCircle = CircleRecognition(x);

%% row subsection (dim:28)
RowSubsectionVector =  RowSubsection(x);

%% left&right sides contour (dim: 28+28) 
[LeftContourVector RightContourVector] = LRSidesContour(x);


ftrVector = [isCircle, RowSubsectionVector, LeftContourVector, RightContourVector];


