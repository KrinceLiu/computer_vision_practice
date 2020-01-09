I1 = imread('../data/cv_cover.jpg');
if (ndims(I1) == 3)
    I1 = rgb2gray(I1);
end
I1 = double(I1) / 255;

I1_points = detectFASTFeatures(I1);
[I1_features, I1_valid_points] = computeBrief(I1, I1_points.Location);

I2 = imrotate(I1,18*10);
%% Compute features and descriptors
I2_points = detectFASTFeatures(I2);
[I2_features, I2_valid_points] = computeBrief(I2, I2_points.Location);
%% Match features
indexPairs = matchFeatures(I1_features,I2_features,'MatchThreshold', 10.0,'MaxRatio',0.7);
locs1 = I1_valid_points(indexPairs(:,1),:);
locs2 = I2_valid_points(indexPairs(:,2),:);

figure;
showMatchedFeatures(I1, I2, locs1, locs2, 'montage');
