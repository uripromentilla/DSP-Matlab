% read and display image
img = imread('ir_cam_im.bmp');
% imshow(img);

% histogram equalization (method 2)
% PARAMETER: number of gray levels (typically 256), intensity range, scaling
L = 64;
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

% thersholding1: split the histogram into half based on cumulative frequency
totalfreq = 0;
half = sum(histedcount)/2;
for i=1:length(histedcount)
    totalfreq = totalfreq + histedcount(i);
    if totalfreq > half
        threshold1 = i;
        break;
    end
end
% binarization1
bin1img = img;
for r=1:row
    for c=1:col
        if bin1img(r,c) < threshold1
            bin1img(r,c) = 0;
        else
            bin1img(r,c) = 255;
        end
    end
end

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




figure('Name','Binarization Images','NumberTitle','off');
subplot(1,3,1);
imshow(img);
title('Original Image');
subplot(1,3,2);
imshow(bin1img);
title('Binarized(by Cumulative Frequency/2) Image');
subplot(1,3,3);
imshow(bin2img);
title('Binarized(by Averaging 2 Peaks) Image');






