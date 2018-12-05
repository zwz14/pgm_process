% 在非手有效区域选择6个种子点，用来拟合平面
function [seed_cluster_test] = pick_seed(data_x, data_y, z_image_double_small)
m_class = [70, 130];
n_class = [140, 224, 308];
[m_num1, m_num] = size(m_class);
[n_num1, n_num] = size(n_class);
mn = m_num * n_num;
seed_cluster_test = zeros(mn,3);
p = 1;
for i = 1 : m_num
    for j = 1 : n_num
        k = m_class(i);
        l = n_class(j);
        seed_cluster_test(p,:) = [data_x(k, l), data_y(k, l), z_image_double_small(k, l)];
        p = p + 1;
    end
end
end