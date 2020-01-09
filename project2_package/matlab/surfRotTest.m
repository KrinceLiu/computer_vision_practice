% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I1 = imread('../data/cv_cover.jpg');
if (ndims(I1) == 3)
    I1 = rgb2gray(I1);
end
I1 = double(I1) / 255;

%% Compute the features and descriptors
I1_points = detectSURFFeatures(I1);
[I1_features, I1_valid_points] = extractFeatures(I1, I1_points,'Method', 'SURF');

%% create histogram
count = [];
degree = linspace(0,360,360/10 +1);

for i = 0:36
    %% Rotate image
    I2 = imrotate(I1,i*10);
    %% Compute features and descriptors
    I2_points = detectSURFFeatures(I2);
    [I2_features, I2_valid_points] = extractFeatures(I2, I2_points,'Method', 'SURF');
    %% Match features
    indexPairs = matchFeatures(I1_features,I2_features,'MatchThreshold', 10.0,'MaxRatio',0.7);
    %% Update histogram
    [x,y] = size(indexPairs);
    count = [count,x];
end


%% Display histogram
bar(degree,count);