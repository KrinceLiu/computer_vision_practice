function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
%Q2.2.3

%% parameters
sample_size = 4;
N = 100;
threshold = 2;
count_inliers = 0;
bestH2to1 = diag([1,1,1]);
inliers = [];
best_x1 = [];
best_x2 = [];
%% loop
for i = 1:N
    %pick 4 points
    [x1,idx] = datasample(locs1,sample_size,'Replace',false);
    x2 = locs2(idx,:);
    %compute H
    temp_H2to1 = computeH_norm(x1,x2);
    temp_inliers = [];
    temp_count_inliers = 0;
    %count inliers
    for j = 1:length(locs2)
        temp = (temp_H2to1 * [locs2(j,:),1]')';
        temp = temp/temp(3);
        if( sqrt(sum((temp(1:2) - locs1(j,:)).^2)) < threshold)
            temp_count_inliers = temp_count_inliers + 1;
            temp_inliers = [temp_inliers, 1];
        else
            temp_inliers = [temp_inliers, 0];
        end
    end
    %update state
    if temp_count_inliers > count_inliers
        count_inliers = temp_count_inliers;
        inliers = temp_inliers;
        bestH2to1 = temp_H2to1;
        best_x1 = x1;
        best_x2 = x2;
    end
    
end 
% cv_cover = imread('../data/cv_cover.jpg');
% cv_desk = imread('../data/cv_desk.png');
% showMatchedFeatures(cv_cover, cv_desk,best_x2, best_x1, 'montage');
end

