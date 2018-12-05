function[cos] = vector_cos(vector1, vector2)
cos = dot(vector1,vector2)/(norm(vector1) * norm(vector2));
end