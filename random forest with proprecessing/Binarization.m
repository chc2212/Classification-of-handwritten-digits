function x = Binarization(x)


%% Binarization
% Otsu


[m,n] = size(x);
Hist = zeros(256);
dHist = zeros(256);
variance = zeros(256);
PXD = 0;

for i = 1:m
    for j = 1:n
        Hist(uint8(x(i,j))+1) = Hist(uint8(x(i,j))+1) + 1;
    end
end

for i = 1:256
    dHist(i) = Hist(i)/(m*n);
end

for PXD = 1:256
    w0 = 0;
    w1 = 0;
    g0 = 0;
    g1 = 0;
    for i = 1:PXD
        g0 = g0 + i*dHist(i);
        w0 = w0 + dHist(i);
    end
    for i = PXD+1 : 256
        g1 = g1 + i*dHist(i);
        w1 = w1 + dHist(i);
    end
    variance(PXD) = w0*w1*(g0 - g1)*(g0 - g1);
end

PXD = 1;
for i = 1:256
    if variance(PXD) < variance(i)
        PXD = i;
    end
end

for  i = 1:m
    for j = 1:n
        if x(i,j) > PXD 
            x(i,j) = 255; % 255
        else
            x(i,j) = 0;
        end
    end
end    




%% Simple implement
% idx1 = find(x>35);
% idx0 = find(x<=35);
% x(idx1) = 1;
% x(idx0) = 0;

%% show pic
%imagesc(x);
