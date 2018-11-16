function[normals_x, normals_y, normals_z, class_plane, z_image_valid,seed_is_merged] = hand_recognition(data_x, data_y, z_image_double)
[m,n] = size(z_image_double);
hand_z_image = zeros(m,n);
threshold = 1000;
z_image_double_small = z_image_double./threshold;
[normals_x, normals_y, normals_z, z_image_valid] = normals(data_x, data_y, z_image_double_small);
[class_plane,seed_is_merged] = normals_cluster(normals_x, normals_y, normals_z, z_image_valid,data_x, data_y, z_image_double_small);
end