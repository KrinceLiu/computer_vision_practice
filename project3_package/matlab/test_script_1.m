%%testscript

%% load mat
mat = load('../data/someCorresp.mat');
pts1 = mat.pts1;
pts2 = mat.pts2;
M = mat.M;

%% compute F
F = eightpoint(pts1,pts2,M);
%
%% test eightpoint
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
% displayEpipolarF(I1,I2,F);

%% test epipolarCorrespondence
epipolarMatchGUI(I1, I2, F);

