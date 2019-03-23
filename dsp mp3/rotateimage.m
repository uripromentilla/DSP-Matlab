% read and display image
img = imread('L_shaped1.bmp');
% imshow(img);

[row, col] = size(img);
rot1 = uint8(zeros(row, col));
rot2 = uint8(zeros(row, col));
% get center points
cx = floor(row/2);
cy = floor(col/2);

theta1 = 90;
theta2 = 90*-1;

% Method 1
theta = theta1;
for r=1:row
    for c=1:col
        x2 = round(cos(theta) * (r-cx) - sin(theta) * (c-cy) + cx);
        y2 = round(sin(theta) * (r-cx) + cos(theta) * (c-cy) + cy);
        if x2 <= row && y2 <= col && x2 >= 1 && y2 >= 1
            rot1(x2,y2) = img(r, c);
        end
    end
end

% Method 2
theta = theta2;
for r=1:row
    for c=1:col
        x2 = round(cos(theta) * (r-cx) - sin(theta) * (c-cy) + cx);
        y2 = round(sin(theta) * (r-cx) + cos(theta) * (c-cy) + cy);
        if x2 <= row && y2 <= col && x2 >= 1 && y2 >= 1
            rot2(r,c) = img(x2, y2);
        end
    end
end

% figure('Name','Rotated Images (L1)','NumberTitle','off');
% subplot(1,3,1);
% imshow(img);
% title('Original Image');
% subplot(1,3,2);
% imshow(rot1);
% title('Rotated Image (M1)');
% subplot(1,3,3);
% imshow(rot2);
% title('Rotated Image (M2)');

img = imread('L_shaped2.bmp');
% imshow(img);
% get center points
cx = floor(row/2);
cy = floor(col/2);

theta1 = 17.9;
theta2 = 17.9*-1;
% Method 1
theta = theta1;
for r=1:row
    for c=1:col
        x2 = round(cos(theta) * (r-cx) - sin(theta) * (c-cy) + cx);
        y2 = round(sin(theta) * (r-cx) + cos(theta) * (c-cy) + cy);
        if x2 <= row && y2 <= col && x2 >= 1 && y2 >= 1
            rot1(x2,y2) = img(r, c);
        end
    end
end
% Method 2
theta = theta2;
for r=1:row
    for c=1:col
        x2 = round(cos(theta) * (r-cx) - sin(theta) * (c-cy) + cx);
        y2 = round(sin(theta) * (r-cx) + cos(theta) * (c-cy) + cy);
        if x2 <= row && y2 <= col && x2 >= 1 && y2 >= 1
            rot2(r,c) = img(x2, y2);
        end
    end
end
figure('Name','Rotated Images (L2)','NumberTitle','off');
subplot(1,3,1);
imshow(img);
title('Original Image');
subplot(1,3,2);
imshow(rot1);
title('Rotated Image (M1)');
subplot(1,3,3);
imshow(rot2);
title('Rotated Image (M2)');



