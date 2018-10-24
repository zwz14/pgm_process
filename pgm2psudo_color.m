function[output_rgb_image, max_pixel, min_pixel] = pgm2psudo_color(input_image)
image = input_image;
min_pixel = min(image(:));
%min_pixel = 300;
% 自动按照灰度阈值，得到图像二值化矩阵
level = graythresh(image);
judge = im2bw(image,level);
temp_image = image;
temp_image(judge == 1) = 0;
max_pixel = max(temp_image(:));
%max_pixel = 800;
A = image - min_pixel;
[row, col] = size(A);
color_range = double(max_pixel - min_pixel);
rgb_range = double(255);
comp = double(rgb_range / color_range);
% initial RGB
R = zeros(row,col);
G = zeros(row,col);
B = zeros(row,col);
% set RGB psudo color
A = double(A);
A1 = A <= color_range/4;
A2 = A > color_range/4 & A <= color_range/2;
A3 = A> color_range/2 & A <= color_range * 3 / 4;
A4 = A > color_range * 3 / 4;

R = R + A1*0 + A2*0 + A3.*(4 * A * comp - 2 * rgb_range) + A4*rgb_range;
G = G + A1.*(4 * A * comp) + A2*rgb_range + A3*rgb_range + A4.*ceil(4 * rgb_range - 4 * A * comp);
B = B + A1*rgb_range + A2.*(-4 * A * comp + 2 * rgb_range) + A3*0 + A4*0;

out = zeros(row,col);
out(:,:,1) = R;
out(:,:,2) = G;
out(:,:,3) = B;
output_rgb_image = out / 256;
end