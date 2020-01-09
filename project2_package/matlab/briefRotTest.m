% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I1 = imread('../data/cv_cover.jpg');
if (ndims(I1) == 3)
    I1 = rgb2gray(I1);
end
I1 = double(I1) / 255;

%% Compute the features and descriptors
I1_points = detectFASTFeatures(I1);
[I1_features, I1_valid_points] = computeBrief(I1, I1_points.Location);

%% create histogram
count = [];
degree = linspace(0,360,360/10 +1);

for i = 0:36
    %% Rotate image
    I2 = imrotate(I1,i*10);
    %% Compute features and descriptors
    I2_points = detectFASTFeatures(I2);
    [I2_features, I2_valid_points] = computeBrief(I2, I2_points.Location);
    %% Match features
    indexPairs = matchFeatures(I1_features,I2_features,'MatchThreshold', 10.0,'MaxRatio',0.7);
    %% Update histogram
    [x,y] = size(indexPairs);
    count = [count,x];
    
end


%% Display histogram
bar(degree,count);