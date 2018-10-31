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

function H = compute_homography_DLT(x1,x2)
    [rows,npts] = size(x1);
    if rows == 2    % Pad data with homogeneous scale factor of 1:
        % the sifts coordinate are given in pixel of the image.
        x1 = [x1; ones(1,npts)];
        x2 = [x2; ones(1,npts)];        
    end
    

    % Attempt to normalise each set of points so that the origin 
    % is at centroid and mean distance from origin is sqrt(2).
    [x1, T1] = normalise2dpts(x1);
    [x2, T2] = normalise2dpts(x2);

    % Note that it may have not been possible to normalise
    % the points if one was at infinity so the following does not
    % assume that scale parameter w = 1.
    
    
    % TODO : Create matrix A
    
    % A= ...
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
    
