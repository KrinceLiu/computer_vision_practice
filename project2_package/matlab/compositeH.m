function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
cover2desk = H2to1;
desk2cover = inv(H2to1);

%% Create mask of same size as template
mask = 255 * ones(size(template,1), size(template,2), 3, 'uint8');

%% Warp mask by appropriate homography
wraped_mask = warpH(mask, cover2desk, size(img));
% imshow(wraped_mask);
%% Warp template by appropriate homography
wraped_template = warpH(template, cover2desk, size(img));
% imshow(wraped_template);
%% Use mask to combine the warped template and the image
composite_img = img;
for i = 1:size(img,1)
    for j = 1:size(img,2)
        if(isequal(reshape(wraped_mask(i,j,:),1,[]),[255,255,255]))
            composite_img(i,j,:) = wraped_template(i,j,:);
        end
    end
end

end