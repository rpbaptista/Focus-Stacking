clear all;
load test;

global data1;
global data2;

clear Y;
clear X;

data1=reshape(iwa(area_of_overlap),[3 length(iwa(area_of_overlap))/3]);
data1=[data1; ones(1,size(data1,2))];
data2=reshape(iwb(area_of_overlap),[3 length(iwb(area_of_overlap))/3]);


%data1=data1(:,1:2);

%data2=data2(:,1:2);
init=mrdivide(data2,data1);

close all
first=reshape(iwa,3,[]);temp=init*[first;ones(1,size(first,2))];
iwa4=reshape(temp,size(iwa));
average=max(iwb,iwa4);
%figure;
%imshow(average);
area_of_overlap=and(~isnan(iwa4),~isnan(iwb));
norm(iwa4(area_of_overlap)-iwb(area_of_overlap))
average(area_of_overlap)=(iwa4(area_of_overlap)+iwb(area_of_overlap))/2;
figure;
imshow(average);

options = optimoptions('lsqnonlin','Display','iter');


M=lsqnonlin(@myfun,init,[],[],options);
close all
first=reshape(iwa,3,[]);temp=fromlineartosrgb(M*fromsrgbtolinear([first;ones(1,size(first,2))]));
iwa5=reshape(temp,size(iwa));
average=max(iwb,iwa5);
figure;
imshow(average);
area_of_overlap=and(~isnan(iwa4),~isnan(iwb));
norm(iwa5(area_of_overlap)-iwb(area_of_overlap))
average(area_of_overlap)=(iwa5(area_of_overlap)+iwb(area_of_overlap))/2;
figure;
imshow(average);




%% SANS OFFSET
clear all;
close all;
load test;
global data1;
global data2;
data1=reshape(iwa(area_of_overlap),[3 length(iwa(area_of_overlap))/3]);
data2=reshape(iwb(area_of_overlap),[3 length(iwb(area_of_overlap))/3]);
clear X,Y;

%data1=data1(:,1:2);

%data2=data2(:,1:2);
init=mrdivide(data2,data1);

close all
first=reshape(iwa,3,[]);temp=init*[first];
iwa4=reshape(temp,size(iwa));
average=max(iwb,iwa4);
%figure;
%imshow(average);
area_of_overlap=and(~isnan(iwa4),~isnan(iwb));
norm(iwa4(area_of_overlap)-iwb(area_of_overlap))
average(area_of_overlap)=(iwa4(area_of_overlap)+iwb(area_of_overlap))/2;
figure;
imshow(average);

options = optimoptions('lsqnonlin','Display','iter');


M=lsqnonlin(@myfun,init,[],[],options);

first=reshape(iwa,3,[]);temp=fromsrgbtolinear(M*fromlineartosrgb([first]));
iwa5=reshape(temp,size(iwa));
average=max(iwb,iwa5);
figure;
imshow(average);
area_of_overlap=and(~isnan(iwa4),~isnan(iwb));
norm(iwa5(area_of_overlap)-iwb(area_of_overlap))
average(area_of_overlap)=(iwa5(area_of_overlap)+iwb(area_of_overlap))/2;
figure;
imshow(average);


