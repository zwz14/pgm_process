clear;
% ---set file name---
name = 'sampleImage.pgm';
bin_file_name = 'short_throw_depth_camera_space_projection.bin';
z_compensate_name = 'z_compensate.bytes';

% ---read data from file---
real_image = imread(name);
z_c_file = fopen(z_compensate_name, 'w');
bin_file = fopen(bin_file_name, 'r');

% ---change depth from distance to origin to z value---
[data_x, data_y, data_z] = process_bin(bin_file);
data_compensate = sqrt(data_x.^2 + data_y.^2 + data_z.^2);
data_compensate(data_compensate == Inf) = 1;
z_c_count = fwrite(z_c_file, data_compensate(:), 'float32');
real_image_double = double(real_image);
z_image_double = real_image_double ./ data_compensate;

% ---show 3D point cloud image--- 
x_image_double = data_x .* real_image_double ./ data_compensate;
y_image_double = data_y .* real_image_double ./ data_compensate;
[seed_cluster_test,plane_distance,plane_value] = hand_recognition_test(x_image_double, y_image_double, z_image_double);
% 删除无效3D点
y_image_double(x_image_double == inf) = 0;
z_image_double_1 = z_image_double;
z_image_double_1(x_image_double == inf) = 0;
z_image_double_1(z_image_double_1 > 1000) = 0;
x_image_double(x_image_double == inf) = 0;
x_image_double(z_image_double_1 == 0) = 0;
y_image_double(z_image_double_1 == 0) = 0;
% 隔6个点取一个样
all_sample_size = size(x_image_double(:));
sample = 1: 4: all_sample_size;
x_image_double_line = x_image_double(:);
y_image_double_line = y_image_double(:);
z_image_double_line = z_image_double_1(:);
x_sample = x_image_double_line(sample);
y_sample = y_image_double_line(sample);
z_sample = z_image_double_line(sample);
% 画散点图
figure('NumberTitle','off','Name','3D点云'), scatter3( -x_sample,y_sample,z_sample, 3,z_sample);
% 画拟合平面
xlabel('x轴');
ylabel('y轴');
zlabel('z轴');
x_scale = -800:10:800;
y_scale = -400:10:600;
[X_plane,Y_plane] = meshgrid(x_scale,y_scale);
a = plane_value(1,1);
b = plane_value(1,2);
c = plane_value(1,3);
d = plane_value(1,4);
Z_plane = (-a * X_plane - b * Y_plane - d) / c;
hold on;
surf(X_plane,Y_plane,Z_plane);

% ---get and show psudo_color image---
z_image = uint16(z_image_double);
[output_rgb_image, max_pixel, min_pixel] = pgm2psudo_color(z_image);
figure('NumberTitle','off','Name','深度伪彩色图'), imshow(output_rgb_image), impixelinfo;

% ---close all open file----
fclose(bin_file);
fclose(z_c_file);
