function[a,b,c,d] = fit_plane(seed_cluster_test)
xyz0=mean(seed_cluster_test,1);
centeredPlane=bsxfun(@minus,seed_cluster_test,xyz0);
[U,S,V]=svd(centeredPlane);
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
end