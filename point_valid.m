% �жϵ��Ƿ�����Ч�㣺����Ч�����ڣ�����ֵС��1000���жϷ����ο�readme
function[is_valid] = point_valid(i, j, data_x, z_image_double)
[m,n] = size(z_image_double);
is_valid = true;
threshold = 1000;
if i == 1 || i == m || j == 1 || j == n
    is_valid = false;
elseif z_image_double(i,j)>threshold || z_image_double(i-1,j)>threshold || z_image_double(i+1,j)>threshold || z_image_double(i,j-1)>threshold || z_image_double(i,j+1)>threshold
    is_valid = false;
elseif data_x(i,j) == inf || data_x(i-1,j) == inf || data_x(i+1,j) == inf || data_x(i,j-1) == inf || data_x(i,j+1) == inf 
    is_valid = false;
end
end