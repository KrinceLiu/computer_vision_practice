function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

%% parameters 
[H,W,D] = size(im1);
dispM = ones(H,W);
w = (windowSize-1)/2;

for y = 1:H
    for x = 1:W
        if y-w < 1 || y+w > H || x-w < 1 || x+w > W
            continue
        end
        temp_distance = [];
        temp_d = [];
        subimg_1 = im1(y-w:y+w,x-w:x+w);
        for d = 0:maxDisp
            if y-w < 1 || y+w > H || x-w-d < 1 || x+w-d > W
                continue
            end
            subimg_2 = im2(y-w:y+w,x-w-d:x+w-d);
            temp_distance = [temp_distance,sum((subimg_1(:) - subimg_2(:)) .^ 2)];
            temp_d = [temp_d,d];
        end
        d = temp_d(find(temp_distance==min(temp_distance),1));
        dispM(y,x) = d;

    end
end
