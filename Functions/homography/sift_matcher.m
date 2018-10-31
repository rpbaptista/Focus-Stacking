function [match] = sift_matcher(K1, loc1, K2, loc2,treshold_ratio)

% Each row of K's contains a descriptor
% The rows of the loc's contain the corresponding positions in pixels
% of the descriptor
% 

treshold_ratio=treshold_ratio*treshold_ratio; % we compute squared distances


funnyno = 100000000; %max float-like number.


 m=1;
for i=1:size(K1, 1)
  keypoint = K1(i, :);
  keylist = K2;
  
  distq1 = funnyno;
  distq2 = funnyno;
  
  for j=1:size(keylist, 1)
      dist = sum((keypoint - keylist(j, :)).^2);      
      if (dist < distq1)
          distq2 = distq1;
          distq1 = dist;
          minkey = j;
      elseif (dist < distq2)
          distq2 = dist;
      end
  end
  
  
 
  if ( distq1 < treshold_ratio * distq2)
      % distq1 closest distance (squared)
      % distq2 2nd closest distance
      a = loc1(i, :);
      b = loc2(minkey, :); %=> minkey: position of the key that realize the min
      match(m, 1) = a(1);
      match(m, 2) = a(2);
      match(m, 3) = b(1);
      match(m, 4) = b(2);
      m = m + 1;
  end
end


