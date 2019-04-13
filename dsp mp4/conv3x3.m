% test images
testimg1 = [1 2 3
           4 5 6
           7 8 9];
       
testimg2 = [9 8 7
            6 5 4
            3 2 1];

iden = [0 0 0
        0 1 0
        0 0 0];   
    
shiftsub = [0 0 0
            0 1 0
            0 0 -1];
       
% CAMERAMAN
img = imread('cameraman.png');
img = rgb2gray(img);

figure('Name','Cameraman Shift and Subtract Image','NumberTitle','off');
subplot(1,3,1);
imshow(img);
title('Original Image')

convimg1 = uint8(conv2(img, shiftsub));
subplot(1,3,2);
imshow(convimg1);
title('Conv2 Image')

convimg2 = uint8(myconv(img, shiftsub));
subplot(1,3,3);
imshow(convimg2);
title('Own Implementation Image')

% BAG AND XRAY
img = imread('bag_xray.bmp');

% Shift and Subtract
shiftsub = [0 0 0
            0 1 0
            0 0 -1];
convimg = uint8(myconv(img, shiftsub));
figure('Name','Shift and Subtract Image','NumberTitle','off');
imshow(convimg);

% Edge Detection K=20
k = 20;
edgedec = [-1/k -1/k -1/k
           -1/k   1  -1/k
           -1/k -1/k -1/k];
convimg = uint8(myconv(img, edgedec));
figure('Name','Edge Detection Image [k=20]','NumberTitle','off');
imshow(convimg);

% Edge Detection K=10
k = 10;
edgedec = [-1/k -1/k -1/k
           -1/k   1  -1/k
           -1/k -1/k -1/k];
convimg = uint8(myconv(img, edgedec));
figure('Name','Edge Detection Image [k=10]','NumberTitle','off');
imshow(convimg);

% Edge Detection K=8
k = 8;
edgedec = [-1/k -1/k -1/k
           -1/k   1  -1/k
           -1/k -1/k -1/k];
convimg = uint8(myconv(img, edgedec));
figure('Name','Edge Detection Image [k=8]','NumberTitle','off');
imshow(convimg);

% Edge Detection with Thersholding
convimg = uint8(myconv(img, edgedec));

% Automatic Thresholding
timg = convimg;
threshold = mean(timg, 'all');
lim = 3;
diff = 100;

while diff > lim
    backg = timg(timg <= threshold);
    foreg = timg(timg > threshold);
    backgmean = mean(backg, 'all');
    foregmean = mean(foreg, 'all');
    newthreshold = mean([backgmean, foregmean]);
    diff = abs(newthreshold - threshold);
    threshold = newthreshold;
end
% Binarization
binimg = convimg;
[row, col] = size(binimg);
for r=1:row
    for c=1:col
        if binimg(r,c) > threshold
            binimg(r,c) = 0;
        else
            binimg(r,c) = 255;
        end
    end
end
figure('Name','Thresholding Image (Threshold = 10)','NumberTitle','off');
imshow(binimg);

        