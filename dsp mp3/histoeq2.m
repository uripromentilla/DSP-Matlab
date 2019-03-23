% METHOD2

% read and display image
img = imread('ir_cam_im.bmp');
% imshow(img);

% PARAMETER: number of gray levels (typically 256), intensity range, scaling
L = 256;

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

% % for COMPARING/TESTING with the actual histeq functions
% histequalized = histeq(img);
% [counts,binLocations] = imhist(img);

figure('Name','Histogram Equalization Images','NumberTitle','off');
subplot(1,2,1);
imshow(img);
title('Original Image');
subplot(1,2,2);
imshow(histedimg2);
title('Histogram Equalized Image');

figure('Name','Histogram (Using histogram function)','NumberTitle','off');
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
subplot(1,2,1);
histogram(count,binlocation);
title('Original Histogram');
subplot(1,2,2);
histogram(histedcount,binlocation);
title('Histogram Equalized Histogram');


figure('Name','Histogram (Using imhist function)','NumberTitle','off');
subplot(1,2,1);
imhist(img);
title('Original Histogram');
subplot(1,2,2);
imhist(histedimg2);
title('Histogram Equalized Histogram');




    
    
    
    
