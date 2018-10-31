function [Listwarped ] = warp( ListH,Listimg,length )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% compute  bounding box
bb=zeros(4,length);
for i=1:length
bb(:,i)=compute_bounding_box(ListH{i,1},Listimg{i,1});
end
finalbb=[max(bb(1,:)) min(bb(2,:)) max(bb(3,:)) min(bb(4,:))];
Listwarped = cell(length,1);
for i=1:length
Listwarped{i,1}=vgg_warp_H(Listimg{i,1}, ListH{i,1}, 'cubic',finalbb);
end

end


