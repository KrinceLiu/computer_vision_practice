function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

%% get parameters
im1 = double(im1);
im2 = double(im2);
[H,W,D] = size(im1);
[H2,W2,D2] = size(im2);
[N,] = size(pts1);
%% loop all points in pts1
pts2 = [];
window = 10;
for n = 1:N
    x1 = round(pts1(n,1));
    y1 = round(pts1(n,2));
    subimg_1 = im1(y1-window:y1+window,x1-window:x1+window,:);
    l = F * [x1,y1,1]';
    point2 = [];
    distance = [];
    %% loop all range in im2
    for x2 = 1+window:W-window
        y2 = round((-l(3) - l(1)*x2)/l(2));
        subimg_2 = im2(y2-window:y2+window,x2-window:x2+window,:);
        point2 = [point2 ; x2,y2];
        distance = [distance; sqrt(sum((subimg_1(:) - subimg_2(:)) .^ 2))];
    end
    I = find(distance==min(distance),1);
    pts2 = [pts2;point2(I,:)];
end
