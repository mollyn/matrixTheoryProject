%% Deblurring an Image
% By Gloria Diederich, Alyson Grassi, and Molina Nichols


%% Deblurring Using Blind Convolution Algorithm: Proof of Concept

%%%
% https://www.mathworks.com/help/images/examples/deblurring-images-using-the-blind-deconvolution-algorithm.html
%%%

image = imread('distantPlanet.jpg');  % change name to fit the desired image file name

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Restore image using PSF of various sizes ...
undersized = ones(size(psf)-4);
[j1, p1] = deconvblind(blurredImage,undersized);

% display attempt at deblur
figure();
imshow(j1);
title('Deblurring with Undersized PSF');

oversized = padarray(undersized,[4 4], 'replicate', 'both');
[j2, p2] = deconvblind(blurredImage,oversized);

% display attempt at deblur
figure();
imshow(j2);
title('Deblurring with Oversized PSF');



