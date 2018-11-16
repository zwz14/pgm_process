function[seed_cluster_test,plane_distance,plane_value] = hand_recognition_test(data_x, data_y, z_image_double)
[m,n] = size(z_image_double);
threshold = 1;
z_image_double_small = z_image_double./threshold;
seed_cluster_test = pick_seed(data_x, data_y, z_image_double_small);
[a,b,c,d] = fit_plane(seed_cluster_test);
plane_value = [a,b,c,d];
plane_distance = zeros(m,n);
z_image_valid = true(m,n);
for i = 1:m
    for j = 1:n
        if point_valid(i, j, data_x, z_image_double)
            z_image_valid(i,j) = false;
            P = [data_x(i,j), data_y(i,j), z_image_double_small(i,j)];
            plane_distance(i,j) = abs(a*P(1,1) + b*P(1,2) + c*P(1,3) + d)/sqrt(a^2+b^2+c^2);
        end
    end
end
% 统计距离分布时删去无效点
plane_distance_line = plane_distance;
plane_distance_line(z_image_valid) = [];
figure, histogram(plane_distance_line,300);
plane_distance_class = plane_distance;
thres = 0.65;
plane_distance_class(plane_distance_class > thres) = 1;
plane_distance_class(plane_distance_class <= thres) = 0;
figure,imshow(plane_distance_class), impixelinfo;
end