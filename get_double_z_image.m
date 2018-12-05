% 获取实际深度值，方法参考readme中的资料
function[z_image_double] = get_double_z_image(real_z_image)
[m,n] = size(real_z_image);
z_compensate_name = 'z_compensate.bytes';
z_compensate_file = fopen(z_compensate_name, 'r');
[data_compensate, data_compensate_num] = fread(z_compensate_file, 'float32');
data_compensate = reshape(data_compensate, m, n);
fclose(z_compensate_file);
z_image_double = double(real_z_image) ./ data_compensate;
end