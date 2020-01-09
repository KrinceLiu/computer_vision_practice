function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

[height1,] = size(pts1);
[height2,] = size(pts2);
height = min(height1,height2);
%% normalize
pts1 = pts1/M;
pts2 = pts2/M;
%% solve for F
A = [];
for i = 1:height
    x = pts1(i,1);
    y = pts1(i,2);
    xp = pts2(i,1);
    yp = pts2(i,2);
    A_layer = [x*xp,  x*yp,  x,   y*xp,   y*yp,   y,   xp,   yp,   1];
    A = [A ; A_layer];
end
A = A' * A;
[V,D] = eig(A);
[d,ind] = sort(diag(D));
Ds = D(ind,ind);
Vs = V(:,ind);
F = reshape(Vs(:,1),[3,3])';
%% enforce rank 2
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';
%% refine F
F = refineF(F,pts1,pts2);
%% unnormalize F
M = [1/M,0,0;0,1/M,0;0,0,1];
F = M * F * M;
