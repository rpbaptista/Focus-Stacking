function [ Hab] = homographyMatcher( imargb,imbrgb,sift_thresh,ransac_thresh )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% create grayscale version of each image 
% used for detecting and describing local features
ima = rgb2gray(imargb);
imb = rgb2gray(imbrgb);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIFTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[desc1, loc1] = sift(ima);
[desc2, loc2] = sift(imb);



matches=sift_matcher(desc1, loc1, desc2, loc2,sift_thresh);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lowe uses an other convention for (x,y) axis: convertion.
xat       = matches(:,2)';
yat       = matches(:,1)';
xbt       = matches(:,4)';
ybt       = matches(:,3)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Robustly fit homography
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Specify the inlier threshold (in noramlized image co-ordinates)
%for test
%inliers=1:size(xat,2); %% change to arbitrary 4 points
%Hab = compute_homography_DLT([xat(inliers); yat(inliers)], [xbt(inliers) ;ybt(inliers)]);

[Hab, inliers] = ransacfithomography([xat; yat], [xbt ;ybt], ransac_thresh);


end

