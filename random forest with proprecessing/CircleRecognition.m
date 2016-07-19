function isCircle = CircleRecognition(x)

[height width] = size(x);

isCircle = 0;
piZeroScope = struct;
piZeroScope.numOfZeroScope = 0;
piRDScope = struct;
piRDScope.numOfRDScope = 0;
circles = [];
for ri=1:height
    
    row = x(ri,:);
    t=[];
    if max(row) == 0
        continue;
    end
      
    [ciZeroScope ciRDScope] = InnerScope(row);
    circles = ContinueCircleRowJudgement(piZeroScope, ciZeroScope, piRDScope, ciRDScope, circles);
    
    numOfcircles = size(circles,1);
    if ~isempty(circles) && numOfcircles>0 
        for csi=1:numOfcircles
            circle = circles(csi);
            if circle.topClosed == 1 && circle.bottomClosed == 1;
                isCircle = 1;
                return;
            end
        end
    end
    
    piZeroScope = ciZeroScope;
    piRDScope = ciRDScope;
end


function [iZeroScope iRDScope] = InnerScope(row)
width = length(row);
start0 = 1;
end0 = 1;
start255 = 1;
end255 = 1;
prec = 0;
t = [];
w = [];
iZeroScope = struct;
for ci=1:width
    curc = row(ci);
    if prec == 0 && curc == 0
        end0 = ci;
        if ci == width
            s(1) = start0;
            s(2) = end0;
            t = [t;s];
        end
    elseif prec ~= 0 && curc ~= 0 && ci~=1
        end255 = ci;
        if ci == width
            m(1) = start255;
            m(2) = end255;
            w = [w;m];
        end
    elseif prec == 0 && curc ~= 0 && ci~=1
        s(1) = start0;
        s(2) = end0;
        t = [t;s];
        
        start255 = ci;
        end255=ci;
    elseif prec ~= 0 && curc == 0 && ci ~= width
        m(1) = start255;
        m(2) = end255;
        w = [w;m];
        
        start0 = ci;
        end0 = ci;
    end 
    prec = curc;
end
numOfZeroScope = size(t,1);
t([1,numOfZeroScope],:) = [];
iZeroScope.numOfZeroScope = size(t,1);
iZeroScope.innerZeroScope = t;
iRDScope.numOfRDScope = size(w,1);
iRDScope.innerRDScope = w;


function circles = ContinueCircleRowJudgement(piZeroScope, ciZeroScope, piRDScope, ciRDScope, circles)

numOfcircles = size(circles,1);
if piZeroScope.numOfZeroScope == 0 && ciZeroScope.numOfZeroScope ~= 0 && piRDScope.numOfRDScope ~=0
    for ci=1:ciZeroScope.numOfZeroScope
        zeroScope = ciZeroScope.innerZeroScope;       
        for rdi=1:piRDScope.numOfRDScope
            rdScopde = piRDScope.innerRDScope;
            if zeroScope(ci,1)>=rdScopde(rdi,1) && zeroScope(ci,2)<=rdScopde(rdi,2)
                circle = struct;
                circle.topClosed = 1;
                circle.bottomClosed = 0;
                circle.zeroScopeStart = zeroScope(ci,1);
                circle.zeroScopeEnd = zeroScope(ci,2);
                circles = [circles;circle];
            end
        end           
    end    
elseif piZeroScope.numOfZeroScope ~= 0 && ciZeroScope.numOfZeroScope ~= 0
    if numOfcircles == 0 || isempty(circles)
        return;
    end
    idxToDelete = [];
    for csi=1:numOfcircles
        circle = circles(csi);
        
        for rdi=1:ciRDScope.numOfRDScope
            rdScopde = ciRDScope.innerRDScope;
            if rdScopde(rdi,1)<=circle.zeroScopeStart && rdScopde(rdi,2)>= circle.zeroScopeEnd
                circle.bottomClosed = 1;
                circles(csi) = circle;
                return;
            end
        end    
        
        
        isContinue = 0;
        zeroScope = ciZeroScope.innerZeroScope;
        for czi=1:ciZeroScope.numOfZeroScope           
            if circle.zeroScopeStart > zeroScope(czi,2) || circle.zeroScopeEnd < zeroScope(czi,1) 
                continue;
            else
                isContinue = czi;
            end
        end
        if isContinue~= 0
            circle.zeroScopeStart = zeroScope(isContinue,1);
            circle.zeroScopeEnd = zeroScope(isContinue,2);
            circles(csi) = circle;
        else
            idxToDelete = [idxToDelete,csi];
            %circles(csi) = [];
        end        
    end
    circles(idxToDelete) = [];
elseif piZeroScope.numOfZeroScope ~= 0 && ciZeroScope.numOfZeroScope == 0 &&  ciRDScope.numOfRDScope ~=0
    if numOfcircles == 0 || isempty(circles)
        return;
    end
    for csi=1:numOfcircles
        circle = circles(csi);
        
        for rdi=1:ciRDScope.numOfRDScope
            rdScopde = ciRDScope.innerRDScope;
            if rdScopde(rdi,1)<=circle.zeroScopeStart && rdScopde(rdi,2)>= circle.zeroScopeEnd
                circle.bottomClosed = 1;
                circles(csi) = circle;
            end
        end    
    end
end

