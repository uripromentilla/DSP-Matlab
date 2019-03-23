% Brightness and Contrast
% Draw Rectangle with Generated Noise
row = 32;
col = 80;
% testimage = zeros(row, col, 'uint8');
testimage = randi([0, 255],row, col, 'uint8');

% Draw Squares
for r=5:row-5
    for c=5:25
        testimage(r,c) = 75;
    end
    for c=30:50
        testimage(r,c) = 150;
    end
    for c=55:75
        testimage(r,c) = 225;
    end
end

% % Draw Squares inside Squares
% for r=10:row-10    
%     for c=5+5:25-5
%         testimage(r,c) = 255;
%     end
%     for c=30+5:50-5
%         testimage(r,c) = 255;
%     end
%     for c=55+5:75-5
%         testimage(r,c) = 255;
%     end
% end

% Draw Triangles inside Squares
gap = 2;
startrow = 10;
endrow = row-10;

startcol = 5+5;
endcol = 25-5;
for i=0:9
    for c=startcol:endcol-(gap+i)
        testimage(startrow+i,c) = 71;
    end
    for c=endcol:-1:startcol+(gap+i)
        testimage(endrow-i,c) = 79;
    end
end
startcol = 30+5;
endcol = 50-5;
for i=0:9
    for c=startcol:endcol-(gap+i)
        testimage(startrow+i,c) = 146;
    end
    for c=endcol:-1:startcol+(gap+i)
        testimage(endrow-i,c) = 154;
    end
end
startcol = 55+5;
endcol = 75-5;
for i=0:9
    for c=startcol:endcol-(gap+i)
        testimage(startrow+i,c) = 221;
    end
    for c=endcol:-1:startcol+(gap+i)
        testimage(endrow-i,c) = 229;
    end
end
figure('Name','Test Image','NumberTitle','off');
imshow(testimage);

b100 = testimage + 100;
figure('Name','+100 Brightness Image','NumberTitle','off');
imshow(b100);

d100 = testimage - 100;
figure('Name','-100 Brightness (Darker) Image','NumberTitle','off');
imshow(d100);

t1 = (testimage-40)*4;
figure('Name','T1 Image','NumberTitle','off');
imshow(t1);

t2 = (testimage-135)*10;
figure('Name','T2 Image','NumberTitle','off');
imshow(t2);

t3 = testimage;
[row, col] = size(t3);
for r=1:row
    for c=1:col
        if t3(r,c)<=75
            t3(r,c) = (t3(r,c)-60)*5;
        elseif t3(r,c)>75 && t3(r,c) <225
            t3(r,c) = 125;
        elseif t3(r,c)>=225
            t3(r,c) = (t3(r,c)-185)*5;
        end
    end
end
figure('Name','T3 Image','NumberTitle','off');
imshow(t3);
