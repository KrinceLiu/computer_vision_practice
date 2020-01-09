function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).

c1 = - inv(K1*R1) * (K1 * t1);
c2 = - inv(K2*R2) * (K2 * t2);
b = norm(c1-c2);
f = K1(1, 1);

[H,W] = size(dispM);
depthM = zeros(H,W);

disp(b*f);
for h = 1:H
    for w = 1:W
        if dispM(h,w) ~= 0
            depthM(h,w) = b*f / dispM(h,w);
        end
    end
end
