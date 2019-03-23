% read and display image
L1 = imread('L_shaped1.bmp');
L2 = imread('L_shaped2.bmp');

% COUNT FOR L1

% histogram equalization to spread out the values
img = L1;
L = 128;
% count the intensities
[row, col] = size(img);
count = zeros(256,1);
% the 1 represents intensity 0 [0~255]
for i=1:256
    for r=1:row
        for c=1:col
            if i-1 == img(r,c)
                count(i) = count(i) + 1;
            end
        end
    end 
end
% compute cumulative frequency
cumfreq = zeros(size(count));
cumfreq(1) = count(1);
for i=2:length(cumfreq)
    cumfreq(i) = cumfreq(i-1)+count(i);
end
% get mininum cumulative frequency
for i=1:length(count)
    if count(i) > 0
        cdfmin = i-1;
        break;
    end 
end
% map to scaled values
histedimg2 = img;
M = row;
N = col;
for r=1:row
    for c=1:col
        v = histedimg2(r,c)+1;
        h = floor((cumfreq(v) - cdfmin) / ((M*N) - cdfmin) * (L-1));
        histedimg2(r,c) = h;
    end
end
binlocation = (0:255)';
histedcount = zeros(256,1);
for i=1:256
    for r=1:row
        for c=1:col
            if i-1 == histedimg2(r,c)
                histedcount(i) = histedcount(i) + 1;
            end
        end
    end 
end
% thresholding to cut the values into the L shape and the background
% thersholding2: split the histogram based on the average between 2 peaks
[maxval, maxind] = max(histedcount);
[secval, secind] = max(histedcount(histedcount ~= maxval));
avemax = mean(maxind, secind);
threshold2 = avemax;
% binarization2
bin2img = img;
for r=1:row
    for c=1:col
        if bin2img(r,c) < threshold2
            bin2img(r,c) = 0;
        else
            bin2img(r,c) = 255;
        end
    end
end

% count the white parts aka the L shaped values
countforL1 = 0;
for r=1:row
    for c=1:col
        if bin2img(r,c) == 255
            countforL1 = countforL1+1;
        end
    end
end

% COUNT FOR L2

% histogram equalization to spread out the values
img = L2;
% count the intensities
[row, col] = size(img);
count = zeros(256,1);
% the 1 represents intensity 0 [0~255]
for i=1:256
    for r=1:row
        for c=1:col
            if i-1 == img(r,c)
                count(i) = count(i) + 1;
            end
        end
    end 
end
% compute cumulative frequency
cumfreq = zeros(size(count));
cumfreq(1) = count(1);
for i=2:length(cumfreq)
    cumfreq(i) = cumfreq(i-1)+count(i);
end
% get mininum cumulative frequency
for i=1:length(count)
    if count(i) > 0
        cdfmin = i-1;
        break;
    end 
end
% map to scaled values
histedimg2 = img;
M = row;
N = col;
for r=1:row
    for c=1:col
        v = histedimg2(r,c)+1;
        h = floor((cumfreq(v) - cdfmin) / ((M*N) - cdfmin) * (L-1));
        histedimg2(r,c) = h;
    end
end
binlocation = (0:255)';
histedcount = zeros(256,1);
for i=1:256
    for r=1:row
        for c=1:col
            if i-1 == histedimg2(r,c)
                histedcount(i) = histedcount(i) + 1;
            end
        end
    end 
end
% thresholding to cut the values into the L shape and the background
% thersholding2: split the histogram based on the average between 2 peaks
[maxval, maxind] = max(histedcount);
[secval, secind] = max(histedcount(histedcount ~= maxval));
avemax = mean(maxind, secind);
threshold2 = avemax;
% binarization2
bin2img = img;
for r=1:row
    for c=1:col
        if bin2img(r,c) < threshold2
            bin2img(r,c) = 0;
        else
            bin2img(r,c) = 255;
        end
    end
end

% count the white parts aka the L shaped values
countforL2 = 0;
for r=1:row
    for c=1:col
        if bin2img(r,c) == 255
            countforL2 = countforL2+1;
        end
    end
end

isequal(L1, L2)
isequal(countforL1, countforL2)
countforL1
countforL2
countforL2 - countforL1
    