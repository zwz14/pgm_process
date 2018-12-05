% how to recognize fingertip, please read readme.
function[BW_fingertip,fingertip] = process_BW(BW_erode_valid)
[m,n] = size(BW_erode_valid);
BW_fingertip = false(m,n);
fingertip = [];
BW_connect_cell = bwboundaries(BW_erode_valid);
[connect_num, ~] = size(BW_connect_cell);
% figure, imshow(L/connect_num), impixelinfo;
k = 6;
cos_threshold = 0;
for i = 1:connect_num
    BW_celli = BW_connect_cell{i};
    [celli_m, ~] = size(BW_celli);
    if celli_m < 2*k+1
        continue;
    end
    for j =k+1:celli_m-k
        pointi = BW_celli(j,:);
        pointi_l = BW_celli(j-k,:);
        pointi_r = BW_celli(j+k,:);
        vector1 = pointi - pointi_l;
        vector2 = pointi - pointi_r;
        cos = vector_cos(vector1, vector2);
        if cos > cos_threshold
            fingertip = [fingertip; pointi];
            BW_fingertip(pointi(1,1), pointi(1,2)) = true;
        end
    end
end
% figure, imshow(BW_fingertip);
end