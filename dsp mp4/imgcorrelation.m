
img = imread('Washington.bmp');
targetimg = imread('target_face.bmp');
figure('Name','Original Image','NumberTitle','off');
subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(targetimg);

% rotate image
rotatedimg = imrotate(targetimg,180);
% edge detected image
k = 10;
edgedec = [-1/k -1/k -1/k
           -1/k   1  -1/k
           -1/k -1/k -1/k];
filterkernel = uint8(myconv(rotatedimg, edgedec));
figure('Name','Rotated Edge Detected Image','NumberTitle','off');
subplot(1,2,1);
imshow(rotatedimg);
title('Rotated Image');
subplot(1,2,2);
imshow(filterkernel);
title('Edge Detected Image');

% correlation
% correlation from rotated edgedec kernel filter
% perfect k = 2.92
k = -1/3;
edgedec = [k k k
           k 1 k
           k k k];
edgedecimg2 = uint8(myconv(rotatedimg, edgedec));
corrimg = uint8(myconv(img, edgedecimg2));
% correlation from target image with edgedec
edgedecimg3 = uint8(myconv(targetimg, edgedec));
cortarimg = uint8(myconv(img, edgedecimg3));

figure('Name','Correlation Images','NumberTitle','off');
subplot(1,2,1);
imshow(corrimg);
title("Rotated Correlated Image")
subplot(1,2,2);
imshow(cortarimg);
title("Not Rotated Correlated Image")






        





% FAILED EXPERIMENT 1 of FFT correlation
% fftimg = fft2(img);
% figure('Name','Image','NumberTitle','off');
% imshow(fftimg)
% fftfilt = fft2(edgedecimg2);
% fftfilt = padarray(fftfilt, [35,35]);
% fftfilt = fftfilt(2:length(fftfilt), 2:length(fftfilt));
% figure('Name','Image','NumberTitle','off');
% imshow(fftfilt)
% % fftmult = xcorr2(fftimg, fftfilt);
% fftmult = fftimg.*fftfilt;
% excorrimg = ifft2(fftmult);
% figure('Name','Ex Correlation Image','NumberTitle','off');
% imshow(excorrimg);
% 
% [row, col] = size(excorrimg);
% for r=1:row
%     for c=1:col
%         if excorrimg(r,c) ~= max(excorrimg,[],'all')
%             excorrimg(r,c) = 0;
%         else
%             excorrimg(r,c) = 255;
%         end
%     end
% end
% figure('Name','Ex Correlation Image','NumberTitle','off');
% imshow(excorrimg);

% 
% % FAILED EXPERIMENT 2
% or = row+fr; %-1?
% oc = col+fc;
% output = zeros(or, oc);
% 
% for r=1:or
%     for c=1:oc
%         for j=1:fr
%             for k=1:fc
%                 output(r,c) = output(r,c) + filterkernel(j,k) * img(r-k, c-j);
%             end
%         end
%     end
% end

% FAILED EXPERIMENT 3
% [row, col]  = size(img);
% [fr, fc] = size(filterkernel);
% output = uint8(myconv(padarray(edgedecimg2, [1000,1000]), img));
% figure('Name','Experiment Image','NumberTitle','off');
% imshow(output)

% FAILED EXPERIMENT 4
% max(corrimg, [],'all')
% [row, col] = size(corrimg);
% for r=1:row
%     for c=1:col
%         if corrimg(r,c) == max(corrimg,[],'all')
%             corrimg(r,c) = 255;
%         else
%             corrimg(r,c) = 0;
%         end
%     end
% end
% max(corrimg, [],'all')


