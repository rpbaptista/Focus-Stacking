function bb1=compute_bounding_box(H,im)
%For I2
[m,n,~]=size(im);
y1 = H*[[1;1;1], [1;m;1], [n;m;1] [n;1;1]];
    y1(1,:) = y1(1,:)./y1(3,:);
    y1(2,:) = y1(2,:)./y1(3,:);
    
    
    bb1 = [
      ceil(min(y1(1,:)));
      ceil(max(y1(1,:)));
      ceil(min(y1(2,:)));
      ceil(max(y1(2,:)));
      ];
end

