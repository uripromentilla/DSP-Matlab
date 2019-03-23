% read and display image
img = imread('L_shaped1.bmp');
% imshow(img);

bx = 95; % shift columns
by = 78; % shift rows

[row, col] = size(img);
trans = uint8(zeros(row, col));

for r=1:row
    for c=1:col
        x2 = r+bx;
        y2 = c+by;
        if x2 <= row && y2 <= col && x2 >= 1 && y2 >= 1
            trans(x2, y2) = img(r, c);
        end
    end
end

figure('Name','Translated Images (L1)','NumberTitle','off');
subplot(1,2,1);
imshow(img);
title('Original Image');
subplot(1,2,2);
imshow(trans);
title('Translated Image');

% read and display image
img = imread('L_shaped2.bmp');
% imshow(img);

bx = 45; % shift columns
by = 65; % shift rows

[row, col] = size(img);
trans = uint8(zeros(row, col));

for r=1:row
    for c=1:col
        x2 = r+bx;
        y2 = c+by;
        if x2 <= row && y2 <= col && x2 >= 1 && y2 >= 1
            trans(x2, y2) = img(r, c);
        end
    end
end

figure('Name','Translated Images (L2)','NumberTitle','off');
subplot(1,2,1);
imshow(img);
title('Original Image');
subplot(1,2,2);
imshow(trans);
title('Translated Image');



