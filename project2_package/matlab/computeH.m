function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points

[height1,] = size(x1);
[height2,] = size(x2);
height = min(height1,height2);
A = [];

for i = 1:height
    x = x2(i,1);
    y = x2(i,2);
    xp = x1(i,1);
    yp = x1(i,2);
    
    temp_H2to1 = [-x,   -y,   -1,   0,   0,   0,   x*xp,   y*xp,   xp;
                   0,    0,    0,  -x,  -y,  -1,   x*yp,   y*yp,   yp];
    A = [A ; temp_H2to1];
end

A = A' * A;
[V,D] = eig(A);
[d,ind] = sort(diag(D));
Ds = D(ind,ind);
Vs = V(:,ind);
H2to1 = reshape(Vs(:,1),[3,3])';
end
