function[class_plane,seed_is_merged] = normals_cluster(normals_x, normals_y, normals_z, z_image_valid, data_x, data_y, z_image_double_small)
[m,n] = size(normals_x);
% ��¼���ƽ���λ��
max_plane = zeros(m,n);
% ��¼����ƽ��
class_plane = zeros(m,n);
% ȡ6�����ӵ���о���
m_1 = 100;
m_2 = 105;
n_1 = 126;
n_2 = 224;
n_3 = 332;
seed_index = [m_1,n_1; m_2,n_1; m_1,n_2; m_2,n_2; m_1,n_3; m_2,n_3];
[seed_m, seed_n] = size(seed_index);
seed_normals = zeros(seed_m,3);
for i = 1:seed_m
    s_m = seed_index(i,1);
    s_n = seed_index(i,2);
    if z_image_valid(s_m,s_n)
        seed_normals(i,:) = [normals_x(s_m,s_n), normals_y(s_m,s_n), normals_z(s_m,s_n)];
    else        
        % ��Ԥ��㲻���㣬��ȡ���һ����
        while 1
            s_m = floor(392*rand) + 28;
            s_n = floor(400*rand) + 35;
            if z_image_valid(s_m,s_n)
                seed_index(i,1) = s_m;
                seed_index(i,2) = s_n;
                seed_normals(i,:) = [normals_x(s_m,s_n), normals_y(s_m,s_n), normals_z(s_m,s_n)]; 
                break;
            end                
        end
    end
end
% �������ӵ�ó�Ni*Nj�����ߵ�����Լ�(Pi-Pj)*Ni���������������ߵ��������ֵ
% ���±���parallel����Ni*Nj��vertical����(Pi-Pj)*Ni
parallel_rate = 0.9;
vertical_rate = 2;

max_parallel = 0;
min_vertical = 1;
seed_parallel = 2*ones(seed_m, seed_m);
seed_vertical = 2*ones(seed_m, seed_m);
for i = 1:seed_m-1
    s_i_m = seed_index(i,1);
    s_i_n = seed_index(i,2);
    for j = i+1:seed_m
        s_j_m = seed_index(j,1);
        s_j_n = seed_index(j,2);
        parallel = abs(seed_normals(i,:) * seed_normals(j,:)');
        % Pi Pj���������
        Pi = [data_x(s_i_m, s_i_n), data_y(s_i_m, s_i_n), z_image_double_small(s_i_m, s_i_n)];
        Pj = [data_x(s_j_m, s_j_n), data_y(s_j_m, s_j_n), z_image_double_small(s_j_m, s_j_n)];
        vertical = abs(seed_normals(i,:) * (Pi-Pj)');
        seed_parallel(i,j) = parallel;
        seed_vertical(i,j) = vertical;
        if parallel > max_parallel
            max_parallel = parallel;
        end
        if vertical < min_vertical
            min_vertical = vertical;
        end
    end
end
parallel_theshold = max_parallel * parallel_rate;
vertical_threshold = min_vertical * vertical_rate;
% �������ӵ�����е���о��࣬���ֵ���ӽ������ӵ��У����������㣬���Ϊ����һ��
% ��������Ni*Nj�Լ���С(Pi-Pj)*Ni
all_max_parallel = max_parallel;
all_min_vertical = min_vertical;
display(cputime);
for i = 1:m
    for j = 1:n
        if ~z_image_valid(i,j) || point_is_seed(i,j,seed_index)
            continue;
        end
        temp_normals = [normals_x(i,j), normals_y(i,j), normals_z(i,j)];
        temp_point = [data_x(i, j), data_y(i, j), z_image_double_small(i, j)];
        temp_parrallel = zeros(seed_m,1);
        temp_vertical = zeros(seed_m,1);
        for k = 1:seed_m
            s_m = seed_index(k,1);
            s_n = seed_index(k,2);
            seed_point = [data_x(s_m, s_n), data_y(s_m, s_n), z_image_double_small(s_m, s_n)];
            temp_parrallel(k,1) = temp_normals * seed_normals(k,:)';
            temp_vertical(k,1) = (seed_point - temp_point) * seed_normals(k,:)';
        end
        [temp_max_parrallel, temp_position_p] = max(temp_parrallel);
        [temp_min_vertical, temp_position_v] = max(temp_parrallel);
        % �������ʷ�������ƽ������������class_plane���õ��ע��Ӧ��seed���
        % �������ʷ��಻����ƽ������������������������ӣ�Ѱ������ʵķ��࣬
        % �������ʷ��಻����ƽ���������Ҳ�������ʷ��࣬��seed���Ϊ�����������һ
        if temp_vertical(temp_position_p,1) < vertical_threshold && temp_parrallel(temp_position_p,1) > parallel_theshold
            class_plane(i,j) = temp_position_p;
        else
            new_temp_position_p = seed_m + 1;
            new_temp_parrallel = temp_parrallel(1,1);
            % ��һ�������parallelλ��
            for k = 1:seed_m
                if k ~= temp_position_p
                    new_temp_parrallel = temp_parrallel(k,1);
                    break;
                end
            end
            for k = 1:seed_m
                if k ~= temp_position_p
                    if temp_parrallel(k,1) >= new_temp_parrallel && temp_vertical(k,1) < vertical_threshold
                        new_temp_parrallel = temp_parrallel(k,1);
                        new_temp_position_p = k;
                    end
                end
            end
            class_plane(i,j) = new_temp_position_p;
        end
        % �������parallel����Сvertical
        if all_max_parallel < temp_max_parrallel
            all_max_parallel = temp_max_parrallel;
        end
        if all_min_vertical > temp_min_vertical
            all_min_vertical = temp_min_vertical;
        end
    end
end
% ����������Ƶ����ӽ��кϲ�
all_parallel_theshold = all_max_parallel * parallel_rate;
all_vertical_threshold = all_min_vertical * vertical_rate;
% seed_is_merged�洢�����Ƿ��Ѿ���merge
seed_is_merged = zeros(seed_m,1);
for i = 1:seed_m-1
    if ~seed_is_merged(i,1)
       for j = i+1:seed_m        
           if ~seed_is_merged(j,1) && seed_parallel(i,j) > all_parallel_theshold && seed_vertical(i,j) < all_vertical_threshold
               seed_is_merged(j,1) = 1;
               class_plane(class_plane == j) = i;
           end
        end
    end   
end
display(cputime);
end