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

% compute probabilities
totalelem = numel(img);
countprobs = zeros(size(count));
for i=1:length(count)
    countprobs(i) = count(i)/totalelem;
end

% compute cumulative probabilities
cumprobs = zeros(size(count));
cumprobs(1) = countprobs(1);
for i=2:length(count)
    cumprobs(i) = cumprobs(i-1)+countprobs(i);
end

% pixel scaling
l = L-1;
hepixels = zeros(size(count));
for i=1:length(count)
    hepixels(i) = cumprobs(i)*l;
end

% rounding down / floor
for i=1:length(hepixels)
    hepixels(i) = floor(hepixels(i));
end

% pixel mapping
histedimg = img;
for r=1:row
    for c=1:col
        pixelval = histedimg(r,c);
        histedimg(r,c) = hepixels(pixelval+1);
    end
end 

% % for COMPARING/TESTING with the actual histeq functions
% histequalized = histeq(img);
% [counts,binLocations] = imhist(img);

% figure('Name','Histogram Equalization Images','NumberTitle','off');
% subplot(1,2,1);
% imshow(img);
% title('Original Image');
% subplot(1,2,2);
% imshow(histedimg);
% title('Histogram Equalized Image');

% figure('Name','Histogram Equalization Plots','NumberTitle','off');
% binlocation = 0:255;
% histedcount = zeros(256,1);
% for i=1:256
%     for r=1:row
%         for c=1:col
%             if i-1 == histedimg(r,c)
%                 histedcount(i) = histedcount(i) + 1;
%             end
%         end
%     end 
% end
% subplot(1,2,1);
% plot(count,binlocation);
% title('Original Histogram');
% subplot(1,2,2);
% plot(histedcount,binlocation);
% title('Histogram Equalized Histogram');

figure
imhist(img);
figure
himg = histeq(img);
imhist(himg);
figure
imhist(histedimg);
    
    
    
    
    
