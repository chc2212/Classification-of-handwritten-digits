function [LeftContourVector RightContourVector] = LRSidesContour(x)
[height width] = size(x);

%% LeftContourVector
LeftContourVector = [];
for ri=1:height
    row = x(ri,:);
    for li=1:width
        if row(li) ~= 0
            LeftContourVector = [LeftContourVector, li];
            break;   
        end
        if li == width
            LeftContourVector = [LeftContourVector, width];

        end
    end
    
end


%% RightContourVector
RightContourVector = [];
for ri=1:height
    row = x(ri,:);
    for li=width:-1:1
        if row(li) ~= 0
            rightOffset = width-li;
            RightContourVector = [RightContourVector, rightOffset];
            break;   
        end
        if li == 1
            RightContourVector = [RightContourVector, width];
        end
    end  
end
