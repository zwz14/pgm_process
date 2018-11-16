function [seed_cluster_test] = pick_seed(data_x, data_y, z_image_double_small)
% m_begin = 70;
% m_end = 130;
% n_begin = 154;
% n_end = 294;
% mn = (m_end - m_begin + 1) * (n_begin - n_end + 1);
% seed_cluster_test = zeros(mn,3);
% k = 1;
% for i = m_begin : m_end
%     for j = n_begin : n_end
%         seed_cluster_test(k,:) = [data_x(i, j), data_y(i, j), z_image_double_small(i, j)];
%         k = k + 1;
%     end
% end
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