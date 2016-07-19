function RowSubsectionVector =  RowSubsection(x)

[height width] = size(x);
RowSubsectionVector = [];
for ri=1:height
    row = x(ri,:);
    leftPos = 0;
    rightPos = 0;
    for li=1:width
        leftPos = li;
        if row(li) ~= 0           
            break;
        end
    end
    for li=width:-1:1
        rightPos = li;
        if row(li) ~= 0        
            break;
        end
    end
    if rightPos<leftPos
        pixes = 0;
    else
        pixes = rightPos - leftPos + 1;
    end
    
    RowSubsectionVector = [RowSubsectionVector, pixes];
end