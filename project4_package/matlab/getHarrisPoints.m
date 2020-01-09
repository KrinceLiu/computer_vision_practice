function [points] = getHarrisPoints(I, alpha,k)
    

if (ndims(I) == 3)
    I = rgb2gray(I);
end
I = double(I) / 255;

% parameters
w = 5;
[H,W] = size(I);

%horizontal sobel
h_sobel_x = reshape([1,0,-1,2,0,-2,1,0,-1],3,3)';
Gx = myImageFilter(I,h_sobel_x);

%vertical sobel
h_sobel_y = reshape([1,0,-1,2,0,-2,1,0,-1],3,3);
Gy = myImageFilter(I,h_sobel_y);

% [Gx,Gy] = imgradientxy(I);
Gxx = Gx .* Gx;
Gyy = Gy .* Gy;
Gxy = Gx .* Gy;

% imgx = Gx;
% imgy = Gy;
% %gradient amplitude
% ga = sqrt((imgx .* imgx) + (imgy .* imgy));
% 
% %gradient direction
% gd = atan(imgy ./ imgx);

sum_kernel = ones(w,w);
I11 = reshape(conv2(Gxx,sum_kernel,'same'),1,[]);
I12 = reshape(conv2(Gxy,sum_kernel,'same'),1,[]);
I21 = reshape(conv2(Gxy,sum_kernel,'same'),1,[]);
I22 = reshape(conv2(Gyy,sum_kernel,'same'),1,[]);
det = I11 .* I22 - I12.* I21;
trace = I11 + I22;
R = reshape((det - k * trace.^2),H,W);
% non-maximum supression
for i = 2:H-1
    for j = 2:W-2
        if R(i,j) ~= max(max(R(i-1:i+1,j-1:j+1)))
            R(i,j) = 0;
        end
    end
end

[B,I] = sort(reshape(R,1,[]),'descend');
top_I = I(1:alpha);
[r,c] = ind2sub([H,W],top_I);
points = [r',c'];
end
