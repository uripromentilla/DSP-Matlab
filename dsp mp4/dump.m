% % Using no histeq
% % Best thershold value = 8
% bin1img = convimg;
% [row, col] = size(bin1img);
% for r=1:row
%     for c=1:col
%         if bin1img(r,c) > 8
%             bin1img(r,c) = 0;
%         else
%             bin1img(r,c) = 255;
%         end
%     end
% end
% imshow(bin1img)

% % Using histeq
% % Best thershold value = 112
% bin1img = histed;
% [row, col] = size(bin1img);
% for r=1:row
%     for c=1:col
%         if bin1img(r,c) > 112
%             bin1img(r,c) = 0;
%         else
%             bin1img(r,c) = 255;
%         end
%     end
% end
% imshow(bin1img)


% Histogram Equalization
% histed = histeqm2(convimg, 128);
histed = histeq(convimg);
[beforecounts, beforebinLocations] = imhist(convimg);
[aftercounts, afterbinLocations] = imhist(histed);

% figure('Name','Histogram Equalization Image','NumberTitle','off');
% subplot(1,2,1);
% imhist(convimg);
% title('Histogram before Equalization');
% subplot(1,2,2);
% imhist(histed);
% title('Histogram after Equalization');







% % thersholding1: split the histogram into half based on cumulative frequency
% histedcount = counts;
% totalfreq = 0;
% half = sum(histedcount)/2;
% for i=1:length(histedcount)
%     totalfreq = totalfreq + histedcount(i);
%     if totalfreq > half
%         threshold1 = i;
%         break;
%     end
% end
% % binarization1
% bin1img = convimg;
% [row, col] = size(convimg);
% for r=1:row
%     for c=1:col
%         if bin1img(r,c) < threshold1
%             bin1img(r,c) = 0;
%         else
%             bin1img(r,c) = 255;
%         end
%     end
% end
% figure('Name','Thersholded Image','NumberTitle','off');
% imshow(bin1img);

% % thersholding2: split the histogram based on the average between 2 peaks
% histedcount = counts;
% [maxval, maxind] = max(histedcount);
% [secval, secind] = max(histedcount(histedcount ~= maxval));
% avemax = mean(maxind, secind);
% threshold2 = avemax;
% % binarization2
% bin2img = convimg;
% for r=1:row
%     for c=1:col
%         if bin2img(r,c) < threshold2
%             bin2img(r,c) = 0;
%         else
%             bin2img(r,c) = 255;
%         end
%     end
% end
% figure('Name','Thersholded Image','NumberTitle','off');
% imshow(bin2img)



% BW = imbinarize(convimg);
% imshow(BW);
