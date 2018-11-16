function[normals_x, normals_y, normals_z, z_image_valid] = normals(data_x, data_y, z_image_double_small)
[m,n] = size(z_image_double_small);
normals_x = zeros(m,n);
normals_y = zeros(m,n);
normals_z = zeros(m,n);
% 记录计算法线的点
z_image_valid = zeros(m,n);
z_image_double = z_image_double_small*1000;
for i = 1:m
    for j = 1:n
        if point_valid(i, j, data_x, z_image_double)
            z_image_valid(i,j) = 1;
            X = [data_x(i,j-1)-data_x(i,j+1), data_y(i,j-1)-data_y(i,j+1), z_image_double_small(i,j-1)-z_image_double_small(i,j+1)];
            Y = [data_x(i-1,j)-data_x(i+1,j), data_y(i-1,j)-data_y(i+1,j), z_image_double_small(i-1,j)-z_image_double_small(i+1,j)];
            Z = cross(X, Y);
            [Z_m, Z_n] = size(Z);
            if(isnan(Z(1,1))||isnan(Z(1,2))||isnan(Z(1,3)))
                display(i);
                display(j);
                display(data_x(i,j));
                display(data_y(i,j));
                display(z_image_double_small(i,j));
                display('X: ');
                display(X);
                display('Y: ');
                display(Y);
                display('Z: ');
                display(Z);
                break;
            end
            if Z_n == 3
                % Z标准化
                Z = Z / norm(Z);
                normals_x(i,j) = Z(1,1);
                normals_y(i,j) = Z(1,2);
                normals_z(i,j) = Z(1,3);
            end
        end
    end
end
end