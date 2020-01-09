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
averaga_error = 0.8503;
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
correct_i = find(votes==max(votes),1);
extrinsics = possible_extrinsics(:,:,correct_i);
P2 = K2 * extrinsics;

%% 6-triangulate
% pts3d = triangulate(P1, temple_pts1, P2, temple_pts2);

%% 6-calculate re-projection error
pts1_re = [];
pts2_re = [];
total_error = 0;
pts3d = triangulate(P1, pts1, P2, pts2);
for n = 1:size(pts3d,1)
    temp_re_1 = P1 * [pts3d(n,:),1]';
    temp_re_1 = temp_re_1/temp_re_1(3);
    pts1_re = [pts1_re; temp_re_1(1:2)'];
    
    temp_re_2 = P2 * [pts3d(n,:),1]';
    temp_re_2 = temp_re_2/temp_re_2(3);
    pts2_re = [pts2_re; temp_re_2(1:2)'];
end
for n = 1:size(pts3d,1)
    local_error_1 = sqrt(sum((pts1_re(n,:) - pts1(n,:)).^2));
    local_error_2 = sqrt(sum((pts2_re(n,:) - pts2(n,:)).^2));
    total_error = total_error + local_error_1 + local_error_2;
end
average_error = total_error / (size(pts3d,1) * 2);
disp(averaga_error);