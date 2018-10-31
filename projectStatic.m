%% Project - IMA206
% Authors:
% Renata Baptista - baptista@telecom-paristech.fr
% Roland Akiki - roland.akiki@telecom-paristech.fr


%% Initial configurations
clc;
clear;
%path = 'C:\Users\User\Desktop\Roland\studies\TELECOM\2A\P3\IMA 206\Multifocus proj\';
path = 'C:\Users\Renata Baptista\Desktop\MultiFocus_Project\';

cd(path);
addpath =[path 'Functions\'];
addpath =[path 'Results\'];
addpath =[path 'Data\'];

filename_rose = ['Data\rose\source05_1.tif';'Data\rose\source05_2.tif'];
filename_bug = ['Data\bug\b_bigbug0000_croppped.png'; 'Data\bug\b_bigbug0001_croppped.png';'Data\bug\b_bigbug0002_croppped.png';'Data\bug\b_bigbug0003_croppped.png';'Data\bug\b_bigbug0004_croppped.png';'Data\bug\b_bigbug0005_croppped.png';'Data\bug\b_bigbug0006_croppped.png';'Data\bug\b_bigbug0007_croppped.png';'Data\bug\b_bigbug0008_croppped.png';'Data\bug\b_bigbug0009_croppped.png';'Data\bug\b_bigbug0010_croppped.png';'Data\bug\b_bigbug0011_croppped.png';'Data\bug\b_bigbug0012_croppped.png'];
filename_book = ['Data\book\source01_1.tif';'Data\book\source01_2.tif'];

% choosing data base
filename = filename_rose;
filename_result = 'Results\rose_weight';


%% Creating and setting variable
size_file = size(filename);
max_file = size_file(1);

data_im = cell(max_file,1);
measureBlur = cell(max_file,1);
   
% 1 - laplacian, 2 - variance, 3-gradient 4-Sum-modified-Laplacian 
% 5- Frequency selective weighted median filter
option = 1;
filename_result = [filename_result '_option' num2str(option) '.png'];

for i = 1:max_file
    fullpath = [path filename(i,:)];
    data_im{i,1} = imread(fullpath);
end

%% Calculating measure of Blur
outputimage = focus(data_im,option);
imshow(im2uint8(outputimage));
imwrite(im2uint8(outputimage),filename_result);