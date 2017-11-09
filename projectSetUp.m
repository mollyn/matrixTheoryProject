%% Deblurring an Image
% By Gloria Diederich, Alyson Grassi, and Molina Nichols

% Adding this to see if the changes appropriately get committed. 

%% Deblurring Using Blind Convolution Algorithm: Proof of Concept

%%%
% https://www.mathworks.com/help/images/examples/deblurring-images-using-the-blind-deconvolution-algorithm.html
%%%

image = imread('PAPER-Original_Image.png');  % change name to fit the desired image file name

% display the original image
figure();
imshow(image);
title('Original Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate a blur
% ** Blur simulated using a Gaussian filter representing a point-spread
% function (psf)
psf = fspecial('gaussian',7,10);
blurredImage = imfilter(image,psf,'symmetric','conv');

% display the blurred image
figure();
imshow(blurredImage);
title('Blurred Image');

% display the paper blurred image
paper_blurred = imread('PAPER-Blurred_Image.png');
figure();
imshow(paper_blurred);
title('Paper Blurred Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Restore image using PSF of various sizes ...
undersized = ones([7 7]);
[j1, p1] = deconvblind(paper_blurred,undersized);

% display attempt at deblur
figure();
imshow(j1);
title('Deblurring with Undersized PSF');

oversized = padarray(undersized,[4 4], 'replicate', 'both');
[j2, p2] = deconvblind(paper_blurred,oversized);

% display attempt at deblur
figure();
imshow(j2);
title('Deblurring with Oversized PSF');

% Try again using returned outputs
[j3, p3] = deconvblind(paper_blurred,p1);

figure();
imshow(j3);
title('Deblurring Try2');

% Try again using returned outputs
[j4, p4] = deconvblind(paper_blurred,p2);

figure();
imshow(j4);
title('Deblurring Try3');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Improving using Weights
% https://www.mathworks.com/help/images/ref/deconvblind.html?s_tid=srchtitle

% WEIGHT = edge(paper_blurred(:,:,1),'sobel',.28);
% se1 = strel('disk',1);
% se2 = strel('line',13,45);
% WEIGHT = ~imdilate(WEIGHT,[se1 se2]);
% WEIGHT = padarray(WEIGHT(2:end-1,2:end-1),[1 1]);
% 
% figure();
% imshow(WEIGHT);
% title('Weight Array');
% 
% P1 = p2;
% P1(find(P1 < 0.01))= 0;
% 
% [J2 P2] = deconvblind(paper_blurred(:,:,1),P1,50,[],double(WEIGHT));
% 
% figure();
% imshow(J2);
% title('Newly Deblurred Image');
% 


%% New Image - Attempt

image = imread('PAPER-Original_Image.png');  % change name to fit the desired image file name

% display the original image
figure();
imshow(image);
title('Original Image');

% display the paper blurred image
paper_blurred = imread('PAPER-Blurred_Image.png');
figure();
imshow(paper_blurred);
title('Paper Blurred Image');

% Restore image using PSF of various sizes ...

% ATTEMPT 1
attempt1 = ones([7 7]);
[j1, p1] = deconvblind(paper_blurred,attempt1);

% display attempt at deblur
figure();
imshow(j1);
title('Deblurring with Guess 1');

% ATTEMPT 2
[j2, p2] = deconvblind(paper_blurred,p1);

% display attempt at deblur
figure();
imshow(j2);
title('Deblurring with Guess 2');