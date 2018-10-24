function[read_image] = process_image(input_image)
[m,n] = size(input_image);
read_image = input_image;
% interchange high 8 bits and low 8 bits
for i = 1:m
    for j = 1:n
       input_pixel = input_image(i,j);
       high8 = bitshift(input_pixel,-8);
       low8 = mod(input_pixel,256);
       read_image(i,j) = low8*256 + high8;
    end
end
end
