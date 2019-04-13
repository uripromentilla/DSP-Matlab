
img = imread('stripes.bmp');
figure('Name','Original Image','NumberTitle','off');
imshow(img);

% Smoothing
sf3 = ones(3,3)/10;
sf5 = ones(5,5)/10;
sf3img = uint8(myconv(img, sf3));
sf5img = uint8(myconv(img, sf5));
gauimg = imgaussfilt(img, 10);

figure('Name','Smoothed Images','NumberTitle','off');
subplot(1,3,1);
imshow(sf3img);
title('3x3 Fitler Smoothing')
subplot(1,3,2);
imshow(sf5img);
title('5x5 Filter Smoothing');
subplot(1,3,3);
imshow(gauimg);
title('Gaussian Smoothing');

[row, col] = size(img);


% Subtraction
% 5x5
[sfr, sfc] = size(sf3img);
sf3pimg = sf3img(2:sfr-1, 2:sfc-1);
sub3img = zeros(row, col);
for r=1:row
    for c=1:col
        sub3img(r,c) = img(r,c) - sf3pimg(r,c);
    end
end
% 5x5
[sfr, sfc] = size(sf5img);
sf5pimg = sf5img(3:sfr-2, 3:sfc-2);
sub5img = zeros(row, col);
for r=1:row
    for c=1:col
        sub5img(r,c) = img(r,c) - sf5pimg(r,c);
    end
end
% Gaussian
subgauimg = zeros(row, col);
for r=1:row
    for c=1:col
        subgauimg(r,c) = img(r,c) - gauimg(r,c);
    end
end

figure('Name','Image Subtraction','NumberTitle','off');
subplot(1,3,1);
imshow(sub3img);
title('3x3 Subtracted')
subplot(1,3,2);
imshow(sub5img);
title('5x5 Subtracted');
subplot(1,3,3);
imshow(subgauimg);
title('Gaussian Subtracted');

% Division
% 5x5
[sfr, sfc] = size(sf3img);
sf3pimg = sf3img(2:sfr-1, 2:sfc-1);
div3img = zeros(row, col);
for r=1:row
    for c=1:col
        div3img(r,c) = img(r,c) / sf3pimg(r,c);
    end
end
% 5x5
[sfr, sfc] = size(sf5img);
sf5pimg = sf5img(3:sfr-2, 3:sfc-2);
div5img = zeros(row, col);
for r=1:row
    for c=1:col
        div5img(r,c) = img(r,c) / sf5pimg(r,c);
    end
end
% Gaussian
divgauimg = zeros(row, col);
for r=1:row
    for c=1:col
        divgauimg(r,c) = img(r,c) / gauimg(r,c);
    end
end

figure('Name','Image Division','NumberTitle','off');
subplot(1,3,1);
imshow(div3img);
title('3x3 Divided')
subplot(1,3,2);
imshow(div5img);
title('5x5 Divided');
subplot(1,3,3);
imshow(divgauimg);
title('Gaussian Divided');

