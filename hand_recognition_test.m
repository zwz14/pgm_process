% 在非手有效区域找若干点拟合平面，计算点和平面距离，将一定阈值以内的
% 点定义为手的点。（效果并不好）
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
% 显示灰度值分布
figure('NumberTitle','off','Name','平面距离分布'), histogram(plane_distance_line,300);
% 显示识别手部区域
plane_distance_class = plane_distance;
thres = 25;
logical1 = plane_distance_class > thres;
logical2 = plane_distance_class <= thres;
plane_distance_class(logical1) = 1;
plane_distance_class(logical2) = 0;
figure('NumberTitle','off','Name','识别手部'),imshow(plane_distance_class), impixelinfo;
end