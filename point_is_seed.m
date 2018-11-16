function[is_seed] = point_is_seed(i, j, seed_index)
is_seed = false;
[s_m, s_n] = size(seed_index);
for k = 1:s_m
    if i == seed_index(k,1) && j ==  seed_index(k,2)
        is_seed = true;
        break;
    end
end
end