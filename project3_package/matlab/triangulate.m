function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
p1 = P1(1,:);
p2 = P1(2,:);
p3 = P1(3,:);
p1p = P2(1,:);
p2p = P2(2,:);
p3p = P2(3,:);
[N,] = min(size(pts1),size(pts2));
pts3d = [];
for n = 1:N
    x = pts1(n,1);
    y = pts1(n,2);
    xp = pts2(n,1);
    yp = pts2(n,2);
    A = [ y*p3-p2 ; p1-x*p3 ; yp*p3p-p2p ; p1p-xp*p3p];
    A = A' * A;
    [V,D] = eig(A);
    [d,ind] = sort(diag(D));
    Ds = D(ind,ind);
    Vs = V(:,ind);
    X = Vs(:,1)';
    X = X/X(4);
    pts3d = [pts3d;X(1:3)];
end

