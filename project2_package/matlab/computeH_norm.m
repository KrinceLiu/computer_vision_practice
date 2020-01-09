function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
x1_temp = (x1 - centroid1).^2; 
x1_temp = sqrt(x1_temp(:,1) + x1_temp(:,2));
x1_temp = sqrt(2)*length(x1_temp) / sum(x1_temp);
s1 = x1_temp;

x2_temp = (x2 - centroid2).^2; 
x2_temp = sqrt(x2_temp(:,1) + x2_temp(:,2));
x2_temp = sqrt(2)*length(x2_temp) / sum(x2_temp);
s2= x2_temp;

%% Shift the origin of the points to the centroid
tx1 = -1 * s1 * centroid1(1);
ty1 = -1 * s1 * centroid1(2);
tx2 = -1 * s2 * centroid2(1);
ty2 = -1 * s2 * centroid2(2);

%% similarity transform 1
T1 = [s1,0,tx1;0,s1,ty1;0,0,1];

%% similarity transform 2
T2 = [s2,0,tx2;0,s2,ty2;0,0,1];

%% Compute Homography
x1_t = [];
for i = 1:length(x1)
    x1_t = [x1_t;(T1 * [x1(i,:),1]')'];
end
x1_t = x1_t(:,1:2);

x2_t = [];
for i = 1:length(x2)
    x2_t = [x2_t;(T2 * [x2(i,:),1]')'];
end
x2_t = x2_t(:,1:2);

H2to1 = computeH(x1_t,x2_t);
%% Denormalization
H2to1 = T1^(-1) * H2to1 * T2;

end
