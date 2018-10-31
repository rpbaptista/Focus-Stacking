close all
clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%imargb = double(imread('keble_a.jpg'))/255;
%imbrgb = double(imread('keble_b.jpg'))/255;


imargb = double(imread('trees_000.jpg'))/255;
imbrgb = double(imread('trees_001.jpg'))/255;


% create grayscale version of each image 
% used for detecting and describing local features
ima = rgb2gray(imargb);
imb = rgb2gray(imbrgb);


% show images
figure(1); clf;
subplot(1,2,1); imshow(imargb); axis image; axis off; title('Image a');
subplot(1,2,2); imshow(imbrgb); axis image; axis off; title('Image b');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIFTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%addpath('siftDemoV4')
[desc1, loc1] = sift(ima);
[desc2, loc2] = sift(imb);



matches=sift_matcher(desc1, loc1, desc2, loc2,0.8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lowe uses an other convention for (x,y) axis: convertion.
xat       = matches(:,2)';
yat       = matches(:,1)';
xbt       = matches(:,4)';
ybt       = matches(:,3)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% show all tentative matches
figure(1); clf;
imshow(imargb); hold on;
plot(xat,yat,'+g');
hl = line([xat; xbt],[yat; ybt],'color','y');
title('Tentative correspondences');
axis off;

% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Robustly fit homography
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Specify the inlier threshold (in noramlized image co-ordinates)
%for test
%inliers=1:size(xat,2); %% change to arbitrary 4 points
%Hab = compute_homography_DLT([xat(inliers); yat(inliers)], [xbt(inliers) ;ybt(inliers)]);

t = 0.1;  %% treshold for model valid.
[Hab, inliers] = ransacfithomography([xat; yat], [xbt ;ybt], t);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Warp and composite images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute panorama bounding box
% 
close all
[m,n,~]=size(imbrgb);
bb=compute_bounding_box(Hab,m,n);

figure(5); clf;

% warp image b to mosaic image using an identity homogrpahy
% Image b is chosen as the reference frame
iwb = vgg_warp_H(imbrgb, eye(3), 'cubic',bb);
imshow(iwb); axis image;

% warp image 1 to the reference mosaic frame (image 2) 
figure(6); clf;

iwa = vgg_warp_H(imargb, Hab, 'cubic',bb);  % warp image a to the mosaic image
imshow(iwa); axis image;
figure;imshow(double(max(iwb,iwa))); % combine images into a common mosaic (take maximum value of the two images)
area_of_overlap=and(~isnan(iwa),~isnan(iwb));
figure;
imshow(sum(area_of_overlap,3))
figure;imshow(sum(area_of_overlap,3));
average=max(iwb,iwa);
figure;
imshow(average)

average(area_of_overlap)=(iwa(area_of_overlap)+iwb(area_of_overlap))/2;
figure;
imshow(average);





