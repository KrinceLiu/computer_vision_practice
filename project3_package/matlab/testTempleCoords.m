% A test script using templeCoords.mat
%
% Write your code here
%
%%testscript

%% 1-load mat
mat = load('../data/someCorresp.mat');
pts1 = mat.pts1;
pts2 = mat.pts2;
M = mat.M;
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

%% 2-compute F
F = eightpoint(pts1,pts2,M);

%% 3-load point
mat2 = load('../data/templeCoords.mat');
temple_pts1 = mat2.pts1;
temple_pts2 = epipolarCorrespondence(im1, im2, F, temple_pts1);

%% 4-essential matrix E.
mat3 = load('../data/intrinsics.mat');
K1 = mat3.K1;
K2 = mat3.K2;
E = essentialMatrix(F,K1,K2);

%% 5-P1,P2,  P = K (Intrinsics) * [R|-Rc] (Extrinsics)
P1 = K1 * [eye(3),zeros(3,1)];
%select best Extrinsics, positive depth test voting
possible_extrinsics = camera2(E);
votes = zeros(1,4);
for i = 1:4
    temp_extrinsics = possible_extrinsics(:,:,i);
    temp_P2 = K2 * temp_extrinsics;
    temp_pts3d = triangulate(P1, temple_pts1, temp_P2, temple_pts2);
    for j = 1:size(temp_pts3d,1)    
        positive_depth_test = P1 * [temp_pts3d(j,:),1]';
        if positive_depth_test(3) > 0
            votes(i) = votes(i) + 1;
        end
    end
end
%% 7-correct P2
disp(votes);
correct_i = find(votes==max(votes),1);
extrinsics = possible_extrinsics(:,:,correct_i);
P2 = K2 * extrinsics;

%% 6-triangulate
pts3d = triangulate(P1, temple_pts1, P2, temple_pts2);

%% 8-plot 3D construction (plot3)
plot3(pts3d(:,1),pts3d(:,2),pts3d(:,3),'.');

%% 9-save extrinsic parameters for dense reconstruction
R1 = eye(3);
t1 = zeros(3,1);
R2 = extrinsics(:,1:3);
t2 = extrinsics(:,4);
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
