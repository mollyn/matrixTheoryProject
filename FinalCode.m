%% Matrix Theory Project Code
% https://www.mathworks.com/help/images/examples/deblurring-images-using-the-blind-deconvolution-algorithm.html


image = imread('PAPER-Original_Image.png');  % change name to fit the desired image file name

% display the original full image
figure();
imshow(image);
title('Original Image (Full)');

original = imread('PAPER-Original_cropped2.PNG');  % change name to fit the desired image file name

% display the original cropped image
figure();
imshow(original);
title('Original Image (Cropped)');

% Simulate a blur
% ** Blur simulated using a Gaussian filter representing a point-spread
% function (psf)
psf = fspecial('gaussian',7,10);
blurred = imfilter(original,psf,'symmetric','conv');

% display the blurred cropped image
figure();
imshow(blurred);
title('Blurred Image (Cropped)');


% Deblur with a pdf of assumed size
guessPSF = ones(size(psf));
[j, p] = deconvblind(blurred,guessPSF);

% display attempt at deblur
figure();
imshow(j);
title('Deblurring with Oversized PSF');

%% Better method

WEIGHT = edge(blurred(:,:,1),'sobel',.05); % change the last input number. 
se = strel('disk',2);
WEIGHT = 1-double(imdilate(WEIGHT,se));
WEIGHT([1:3 end-(0:2)],:) = 0;
WEIGHT(:,[1:3 end-(0:2)]) = 0;

figure; imshow(WEIGHT); title('Weight array');

INITPSF = ones(size(psf));

[J, P] = deconvblind(blurred(:,:,1),INITPSF,30,[],WEIGHT);

figure();
imshow(J);
title('Deblurred using weights');