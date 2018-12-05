clear;
name = 'sampleImage.pgm';
IR_name = ['r_', name];
% ---read image---
IR_image = imread(IR_name);
image = imread(name);
real_z_image = image;

% ---edge detection---
z_image_double = get_double_z_image(real_z_image);
valid_point_IR = validpointforIR(z_image_double);
% ��ֵ���Գ�����
low_thres = 0.2;
thres = 0.5;
[BW, thresh] = edge(IR_image, 'canny',[low_thres,thres]);
% ��ʴ�������Ӷϵı�Ե
se = strel('disk',1);
BW_dilate = imdilate(BW, se);
BW_erode = imerode(BW_dilate, se);
% process BW_erode
BW_erode_valid = BW_erode & valid_point_IR;
% ---get and show fingertip---
[BW_fingertip,fingertip] = process_BW(BW_erode_valid);
fingertip = double(BW_erode_valid);
fingertip(BW_fingertip) = 0.5;
figure('NumberTitle','off','Name','ָ��Ҷ�ͼ'), imshow(fingertip);
color_image = gray2color_finger(fingertip);


