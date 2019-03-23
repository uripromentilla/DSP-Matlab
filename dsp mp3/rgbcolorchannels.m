% read and display image
img = imread('fruits_rgb.bmp');
figure('Name','Figure 1: Original Image','NumberTitle','off');
imshow(img);

% Image into rgb color planes
[R,G,B] = imsplit(img);
figure('Name','Figure 2: Red Channel','NumberTitle','off');
colormap(gray);
imshow(R);
figure('Name','Figure 3: Green Channel','NumberTitle','off');
colormap(gray);
imshow(G);
figure('Name','Figure 4: Blue Channel','NumberTitle','off');
colormap(gray);
imshow(B);

% Image to grayscale
RGB = img;
% Extract Red colour component to R, Green colour component to G 
% and Blue colour component to  B  
red=RGB(:, :, 1);
green=RGB(:, :, 2);
blue=RGB(:, :, 3);
% Getting number of rows in M and number of column in N of RGB image matrix 
% ~ is used to ignore dimension of RGB image
% as size(img) function will return row, column and dimension of the RGB image
[M, N, ~]=size(RGB);
 % creating a new 2-d matrix 'gray_img' of size M*N of 'uint8' data type with all 
 % elements  as zero 
 grayimage=zeros(M, N, 'uint8');
 % calculating grayscale values by forming a weighted sum of the R, G, and B components
 % for each pixel
 for i=1:M
     for j=1:N
           grayimage(i, j)=(R(i, j)*0.2)+(G(i, j)*0.7)+(B(i, j)*0.1);
     end
 end
figure('Name','Grayscaled Image','NumberTitle','off');
imshow(grayimage);

