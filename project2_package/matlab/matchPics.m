function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if (ndims(I1) == 3)
    I1 = rgb2gray(I1);
end
I1 = double(I1) / 255;

if (ndims(I2) == 3)
    I2 = rgb2gray(I2);
end
I2 = double(I2) / 255;
%% Detect features in both images
I1_points = detectFASTFeatures(I1);
I2_points = detectFASTFeatures(I2);
%% Obtain descriptors for the computed feature locations
[I1_features, I1_valid_points] = computeBrief(I1, I1_points.Location);
[I2_features, I2_valid_points] = computeBrief(I2, I2_points.Location);
% I1_points = detectSURFFeatures(I1);
% [I1_features, I1_valid_points] = extractFeatures(I1, I1_points,'Method', 'SURF');
% I2_points = detectSURFFeatures(I2);
% [I2_features, I2_valid_points] = extractFeatures(I2, I2_points,'Method', 'SURF');
%% Match features using the descriptors
indexPairs = matchFeatures(I1_features,I2_features,'MatchThreshold', 10.0,'MaxRatio',0.68);

locs1 = I1_valid_points(indexPairs(:,1),:);
locs2 = I2_valid_points(indexPairs(:,2),:);
end

