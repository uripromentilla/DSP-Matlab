
img = imread('L_shaped1.bmp');
% test = imtranslate(img,[100, 100]);
test = imrotate(img,90);
imshow(test);


% % read and display image
% img = imread('ir_cam_im.bmp');
% % imshow(img);
% BW = imbinarize(img);
% imshow(BW);



% image brightness and contrast testing
% img = imread('L_shaped1.bmp');
% subplot(2,1,1);
% imshow(img);
% [M, N, ~]=size(img);
%  for i=1:M
%      for j=1:N
%            img(i,j) = (img(i, j)-25)*2;
%      end
%  end
% subplot(2,1,2)
% imshow(img);