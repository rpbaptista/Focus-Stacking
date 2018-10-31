% HOMOGRAPHY2D - computes 2D homography
%
% Usage:   H = homography2d(x1, x2)
%          H = homography2d(x)
%
% Arguments:
%          x1  - 3xN set of homogeneous points
%          x2  - 3xN set of homogeneous points such that x1<->x2
%         
%           x  - If a single argument is supplied it is assumed that it
%                is in the form x = [x1; x2]
% Returns:
%          H - the 3x3 homography such that x2 = H*x1
%
% This code follows the normalised direct linear transformation 
% algorithm given by Hartley and Zisserman "Multiple View Geometry in
% Computer Vision" p92.
%

function H = compute_homography_DLT_ransac(varargin)
    
    [x1, x2] = checkargs(varargin(:));

    % Attempt to normalise each set of points so that the origin 
    % is at centroid and mean distance from origin is sqrt(2).
    [x1, T1] = normalise2dpts(x1);
    [x2, T2] = normalise2dpts(x2);

    % Note that it may have not been possible to normalise
    % the points if one was at infinity so the following does not
    % assume that scale parameter w = 1.
    
    
    % TODO : Create matrix A
    
    % A= ...
    % correspondence_input[i][j][k]

% i = correspondence_index

% j = 1 for image1
% j = 2 for image2

% k = 1 for xcoordinate
% k = 2 for ycoordinate

%A(2*i-1,:) = [x1(i,1,1), x1(i,1,2), 1, 0, 0, 0, -x2(i,2,1)*x1(i,1,1), -x2(i,2,1)*x1(i,1,2), -x2(i,2,1)];
%A(2*i,:) = [0, 0, 0, x1(i,1,1), x1(i,1,2), 1, -x2(i,2,2)*x1(i,1,1), -x2(i,2,2)*x1(i,1,2), -x2(i,2,2)];
    for i = 1:size(x1,2)
    
    A(i*2-1,:)=[x1(1,i), x1(2,i),1,0,0,0,-x2(1,i)*x1(1,i),-x2(1,i)*x1(2,i),-x2(1,i)];
    A(i*2,:)=[0,0,0, -x1(1,i), -x1(2,i), -1, x2(2,i)*x1(1,i), x2(2,i)*x1(2,i), x2(2,i)];
    end
    
    % TODO : perform SVD
    
    [~,~,V]=svd(A);

   
    % TODO : Extract homography from SVD result

    % H=...
H(1,:)=V(1:3,9);
H(2,:)=V(4:6,9);
H(3,:)=V(7:9,9);
    
    
    % Denormalise
    H = T2\H*T1;
    
    


% clc;
% 
% disp('The computation exited in ');
% disp(iter_no);
% disp(' iterations');  
%--------------------------------------------------------------------------
% Function to check argument values and set defaults

function [x1, x2] = checkargs(arg);
    
    if length(arg) == 2
	x1 = arg{1};
	x2 = arg{2};
	if ~all(size(x1)==size(x2))
	    error('x1 and x2 must have the same size');
	elseif size(x1,1) ~= 3
	    error('x1 and x2 must be 3xN');
	end
	
    elseif length(arg) == 1
	if size(arg{1},1) ~= 6
	    error('Single argument x must be 6xN');
	else
	    x1 = arg{1}(1:3,:);
	    x2 = arg{1}(4:6,:);
	end
    else
	error('Wrong number of arguments supplied');
    end
    