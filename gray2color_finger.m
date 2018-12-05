% 背景白色，手轮廓黑色，指尖红色
function[color_image] = gray2color_finger(fingertip)
[m,n] = size(fingertip);
color_image = zeros(m,n);
R = zeros(m,n);
G = zeros(m,n);
B = zeros(m,n);
% 0-white,1-black, 0.25-green, 0.5-red, 0.75-blue;
for i = 1:m
    for j = 1:n
        switch fingertip(i,j)
            case 0
                R(i,j) = 255;
                G(i,j) = 255;
                B(i,j) = 255;
            case 0.25
                R(i,j) = 0;
                G(i,j) = 255;
                B(i,j) = 0;
%                 display('green');
            case 0.5
                R(i,j) = 255;
                G(i,j) = 0;
                B(i,j) = 0;
%                 display('red');
            case 0.75
                R(i,j) = 0;
                G(i,j) = 0;
                B(i,j) = 255;
            case 1
                R(i,j) = 0;
                G(i,j) = 0;
                B(i,j) = 0;
            otherwise
                R(i,j) = 255;
                G(i,j) = 255;
                B(i,j) = 255;
%                 diplay('otherwise');
        end    
    end
end
color_image(:,:,1) = R;
color_image(:,:,2) = G;
color_image(:,:,3) = B;
figure('NumberTitle','off','Name','指尖伪彩色图'), imshow(color_image/256), impixelinfo;
end