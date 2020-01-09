cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
[locs1, locs2] = matchPics(cv_cover, cv_desk);

H2to1_1 = computeH(locs2,locs1);
H2to1_2 = computeH_norm(locs2,locs1);
H2to1_3 = computeH_ransac(locs2,locs1);
H2to1 = [H2to1_1,H2to1_2,H2to1_3];

[x,y] = size(cv_cover);
sample_point = [randi(x,[10,1]),randi(y,[10,1])];
for j = 1:3
    convert_point = [];
    for i = 1:length(sample_point)
        temp = H2to1(:,j*3-2:j*3) * [sample_point(i,:)';1];
        convert_point = [convert_point;[temp(1)/temp(3),temp(2)/temp(3)]];
    end
    figure;
    showMatchedFeatures(cv_cover, cv_desk, sample_point, convert_point, 'montage');
    title('Showing all matches');
end
