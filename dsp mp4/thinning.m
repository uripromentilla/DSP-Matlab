
origimg = imread('fingerprint.bmp');

% hyperparameters
% 5x5, pd = 2
% 3x3, pd = 1

a = 3; %window length
hp = 1; %padding
origimg = padarray(origimg, [hp,hp], 1);
pr=hp;
pc=hp;

[row, col] = size(origimg);

% Change instantly
img=origimg;
for r=1+pr:row-pr
        for c=1+pr:col-pr
    %         center = r,c
            area = img(r-pr:r+pr, c-pc:c+pc);
            area(a-hp,a-hp) = 100;

    %         if current pixel is black
            if img(r,c) == 0

    %             if at least 1 neighbor is white
                if max(area,[],'all') == 255

    %                 if black neighbor > 1
                    bcount = 0;
                    nb = false;
                    for i=1:a
                        for j=1:a
                            if area(i,j) == 0
                                bcount = bcount+1;
    %                             are there neighboring blacks?

    %                             down
                                if i+1 <= a
                                if area(i+1, j) == 0
                                    nb = true;
                                end
                                end

    %                             up
                                if i-1 >= 1
                                if area(i-1, j) == 0
                                    nb = true;
                                end
                                end

    %                             right
                                if j+1 <= a
                                if area(i, j+1) == 0
                                    nb = true;
                                end
                                end

    %                             left
                                if j-1 >= 1
                                if area(i, j-1) == 0
                                    nb = true;
                                end
                                end

    %                             up left
                                if i-1 >= 1 & j-1 >=1
                                if area(i-1, j-1) == 0
                                    nb = true;
                                end
                                end

    %                             up right
                                if i-1 >= 1 & j+1 <= a
                                if area(i-1, j+1) == 0
                                    nb = true;
                                end
                                end

    %                             down left
                                if i+1 <= a & j-1 >= 1
                                if area(i+1, j-1) == 0
                                    nb = true;
                                end
                                end

    %                             down right
                                if i+1 <= a & j+1 <= a
                                if area(i+1, j+1) == 0
                                    nb = true;
                                end
                                end
                            end
                        end
                    end
                    if bcount > 1 & nb == true
                        img(r,c) = 255;
                    end
                end
            end
        end
end
instant = img;
figure('Name','Thinned Instantly','NumberTitle','off');
imshow(instant);
title('Thinned Instantly'); 

% Change with delay
img = origimg;
change = true;
for ctr=1:1
    imgchange = zeros(row, col);
    change = false;

    for r=1+pr:row-pr
        for c=1+pr:col-pr
    %         center = r,c
            area = img(r-pr:r+pr, c-pc:c+pc);
            area(a-hp,a-hp) = 100;

    %         if current pixel is black
            if img(r,c) == 0

    %             if at least 1 neighbor is white
                if max(area,[],'all') == 255

    %                 if black neighbor > 1
                    bcount = 0;
                    nb = false;
                    for i=1:a
                        for j=1:a
                            if area(i,j) == 0
                                bcount = bcount+1;
    %                             are there neighboring blacks?

    %                             down
                                if i+1 <= a
                                if area(i+1, j) == 0
                                    nb = true;
                                end
                                end

    %                             up
                                if i-1 >= 1
                                if area(i-1, j) == 0
                                    nb = true;
                                end
                                end

    %                             right
                                if j+1 <= a
                                if area(i, j+1) == 0
                                    nb = true;
                                end
                                end

    %                             left
                                if j-1 >= 1
                                if area(i, j-1) == 0
                                    nb = true;
                                end
                                end

    %                             up left
                                if i-1 >= 1 & j-1 >=1
                                if area(i-1, j-1) == 0
                                    nb = true;
                                end
                                end

    %                             up right
                                if i-1 >= 1 & j+1 <= a
                                if area(i-1, j+1) == 0
                                    nb = true;
                                end
                                end

    %                             down left
                                if i+1 <= a & j-1 >= 1
                                if area(i+1, j-1) == 0
                                    nb = true;
                                end
                                end

    %                             down right
                                if i+1 <= a & j+1 <= a
                                if area(i+1, j+1) == 0
                                    nb = true;
                                end
                                end
                            end
                        end
                    end
                    if bcount > 1 & nb == true
                        imgchange(r,c) = true;
                    end
                end
            end
        end
    end
    
    for r=1:row
        for c=1:col
            if imgchange(r,c)
                img(r,c) = 255;
%                 change = true;
            end
        end
    end
end
delay = img;
figure('Name','Thinned with Delay','NumberTitle','off');
imshow(delay);
title('Thinned with Delay'); 

figure('Name','Fingerpint Thinning','NumberTitle','off');
together = min(instant, delay);
subplot(1,2,1);
imshow(origimg);
title('Original');
subplot(1,2,2);
imshow(together);
title('Thinning Instant + Delay Image')


