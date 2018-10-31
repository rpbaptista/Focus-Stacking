clear all;
load test;

close all
source_second_member=X;
source_first=reshape(iwa,3,[]);

second_member=[source_second_member; ones(1,size(source_second_member,2))];
first=[source_first; ones(1,size(source_first,2))];

figure;
imshow(abs((iwb-iwa).*area_of_overlap)*10)

for degree=2:15
    second_member=[second_member;source_second_member.^degree];
    M=mrdivide([Y],second_member);
     first=[first; source_first.^degree];
temp=M*first;
iwa4=reshape(temp,size(iwa));
average=max(iwb,iwa4);
%figure;
%imshow(average);
area_of_overlap=and(~isnan(iwa4),~isnan(iwb));
norm(iwa4(area_of_overlap)-iwb(area_of_overlap))
average(area_of_overlap)=(iwa4(area_of_overlap)+iwb(area_of_overlap))/2;
%figure;
%imshow(average);
figure;
imshow(abs((iwb-iwa4).*area_of_overlap)*10)
end;

second_member=[source_second_member];
first=[source_first];

for degree=2:15
    second_member=[second_member;source_second_member.^degree];
    M=mrdivide([Y],second_member);
     first=[first; source_first.^degree];
temp=M*first;
iwa4=reshape(temp,size(iwa));
average=max(iwb,iwa4);
%figure;
%imshow(average);
area_of_overlap=and(~isnan(iwa4),~isnan(iwb));
norm(iwa4(area_of_overlap)-iwb(area_of_overlap))
average(area_of_overlap)=(iwa4(area_of_overlap)+iwb(area_of_overlap))/2;
%figure;
%imshow(average);
figure;
imshow(abs((iwb-iwa4).*area_of_overlap)*10)
end;