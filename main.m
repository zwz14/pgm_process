clear;
% set file name
name = '16.pgm';
reflect_image_name = ['r_', name];
real_image_name = ['realimage', name];
z_image_name = ['z_', name];
input_image = imread(name);
bin_file_name = 'short_throw_depth_camera_space_projection.bin';
z_compensate_name = 'z_compensate.bytes';
z_c_file = fopen(z_compensate_name, 'w');
% get real depth image
real_image = process_image(input_image);
imwrite(real_image, real_image_name);
% change depth from distance to origin to z value
bin_file = fopen(bin_file_name, 'r');
[data_x, data_y, data_z] = process_bin(bin_file);
data_compensate = sqrt(data_x.^2 + data_y.^2 + data_z.^2);
data_compensate(data_compensate == Inf) = 1;
z_c_count = fwrite(z_c_file, data_compensate(:), 'float32');
real_image_double = double(real_image);
z_image_double = real_image_double ./ data_compensate;
z_image = uint16(z_image_double);
imwrite(z_image, z_image_name);
% get psudo_color image
[output_rgb_image, max_pixel, min_pixel] = pgm2psudo_color(z_image);
% read reflect image
r_image = imread(reflect_image_name);
% show image
figure, imshow(z_image), impixelinfo;
figure, imshow(output_rgb_image), impixelinfo;
figure, imshow(r_image);
% close all open file
fclose(bin_file);
fclose(z_c_file);
