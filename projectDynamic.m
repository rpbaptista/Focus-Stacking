%% Project - IMA206
% Authors:
% Renata Baptista - baptista@telecom-paristech.fr
% Roland Akiki - roland.akiki@telecom-paristech.fr


%% Initial configurations
clc;
clear;
%path = 'C:\Users\User\Dropbox\MultiFocus (1)\dynamic\';
path = 'C:\Users\Renata Baptista\Desktop\MultiFocus_Project\';

cd(path);

%%
addpath('Results\')
addpath('Functions\')
addpath('Data\')
addpath('Functions\homography')

filename_poster = ['Data\poster\Source3.png';'Data\poster\Source2.png';'Data\poster\Source1.png']; %poster
filename_tree = ['Data\tree\Source3.png';'Data\tree\Source2.png';'Data\tree\Source1.png'];
filename_bottle = ['Data\bottle\Source3.png';'Data\bottle\Source2.png';'Data\bottle\Source1.png'];
filename_bench = ['Data\bench\Source2.png';'Data\bench\Source1.png'];
filename_car = ['Data\car\Source3.png';'Data\car\Source2.png';'Data\car\Source1.png'];
%filename_rose = ['rose\source05_1.tif';'rose\source05_2.tif'];
%%filename_bug = ['bug\b_bigbug0000_croppped.png'; 'bug\b_bigbug0001_croppped.png';'bug\b_bigbug0002_croppped.png';'bug\b_bigbug0003_croppped.png';'bug\b_bigbug0004_croppped.png';'bug\b_bigbug0005_croppped.png';'bug\b_bigbug0006_croppped.png';'bug\b_bigbug0007_croppped.png';'bug\b_bigbug0008_croppped.png';'bug\b_bigbug0009_croppped.png';'bug\b_bigbug0010_croppped.png';'bug\b_bigbug0011_croppped.png';'bug\b_bigbug0012_croppped.png'];
%filename_book = ['book\source01_1.tif';'book\source01_2.tif'];

% choosing data base
filename = filename_bench;
filename_result = 'Results\bench_weight';


%% Creating and setting variable
size_file = size(filename);
max_file = size_file(1);

data_im = cell(max_file,1);

for i = 1:max_file
    fullpath = [path filename(i,:)];
    data_im{i,1} = double(imread(fullpath))/255;
end
%%
%siftMatch(data_im{1,1},data_im{2,1})
idx=ceil(max_file/2);
ListH = cell(max_file,1);
ListH{idx,1}=eye(3);
for i = 1:max_file
    if i~=idx
    ListH{i,1}=homographyMatcher(data_im{i,1},data_im{idx,1},0.8,0.1);%%
    end
end
Listwarped=warp(ListH,data_im,max_file);
%% STARTING MULTIFOCUS
size_file = size(filename);
max_file = size_file(1);

data_im = cell(max_file,1);
measureBlur = cell(max_file,1);
   
% 1 - laplacian, 2 - variance, 3-gradient 4-Sum-modified-Laplacian 
% 5- Frequency selective weighted median filter
option = 1;
filename_result = [filename_result '_option' num2str(option) '.png'];
%%

for i=1:max_file
    imwrite(Listwarped{i,1},[filename_result num2str(i) '.png']);
     data_im{i,1} = Listwarped{i,1};
end

outputimage = focus(data_im, option);

imshow(im2uint8(outputimage));
imwrite(im2uint8(outputimage),filename_result);
