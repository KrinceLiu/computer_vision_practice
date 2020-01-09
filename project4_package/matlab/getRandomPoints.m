function [points] = getRandomPoints(I, alpha)
    if (ndims(I) == 3)
        I = rgb2gray(I);
    end
    I = double(I) / 255;

    [H,W] = size(I);
    points = [randperm(H,alpha)',randperm(W,alpha)'];
end