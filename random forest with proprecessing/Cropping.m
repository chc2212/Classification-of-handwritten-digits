function x = Cropping(x)

[height width] = size(x);
rd = [];   % rows to crop
cd = [];   % column to crop

%% cropping
% up to down
for i=1:height
    r = x(i,:);
    if max(r) == 0
        rd = [rd;i];
    else 
        break;
    end
end
% down to up
for i=height:-1:1
    r = x(i,:);
    if max(r) == 0
        rd = [rd;i];
    else 
        break;
    end
end

% left to right
for i=1:width
    c = x(:,i);
    if max(c) == 0
        cd = [cd;i];
    else 
        break;
    end
end
% right to left
for i=width:-1:1
    c = x(:,i);
    if max(c) == 0
        cd = [cd;i];
    else 
        break;
    end
end
%imagesc(x);
% crop
x(rd,:) =[];
x(:,cd) =[];
%imagesc(x);

%% resize to 28x28
[height width] = size(x);
top = floor((28-height)/2);
down = 28-height-top;
x = [zeros(top, width);x;zeros(down, width);];
%imagesc(x);
left = floor((28-width)/2);
right = 28-width-left;
x = [zeros(28, left) x zeros(28, right);];
%imagesc(x);






