% 判断点是否是有效点：在有效区域内，且数值小于1000。判断方法参考readme
function[valid_point_IR] = validpointforIR(z_image_double)
% initial logical matrix: valid_point_IR
[m,n] = size(z_image_double);
valid_point_IR = true(m,n);
% get data_x
bin_file_name = 'short_throw_depth_camera_space_projection.bin';
bin_file = fopen(bin_file_name, 'r');
[data_x, data_y, data_z] = process_bin(bin_file);
fclose(bin_file);
% set false point
threshold = 1000;
valid_point_IR(data_x == inf) = false;
valid_point_IR(z_image_double > threshold) = false;
valid_point_IR(1:130,:) = false;
end
