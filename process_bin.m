function[data_x, data_y, data_z] = process_bin(bin_file)
% image width and height
m = 450;
n = 448;
% process images
[data, num] = fread(bin_file, 'float32');
odd = 1:2:(num-1);
even = 2:2:num;
data_x = reshape(data(odd), m, n);
data_y = reshape(data(even), m, n);
data_z = ones(m,n);
% imshow(data_x);
% pic_tool = impixelinfo;
end