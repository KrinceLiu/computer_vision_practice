im = imread('../data/desert/sun_acqlitnnratfsrsk.jpg');

% %% feature response
% filterBank = createFilterBank();
% % imshow(im);
% filterResponses = extractFilterResponses(im,filterBank);
% im2 = im;
% im2(:,:,1) = filterResponses(:,:,1);
% im2(:,:,2) = filterResponses(:,:,2);
% im2(:,:,3) = filterResponses(:,:,3);
% imshow(uint8(rescale(filterResponses(:,:,50),0,255)));

%% points detection
if (ndims(im2) == 3)
    im2 = rgb2gray(im);
end
im2 = double(im2) / 255;

points = getRandomPoints(im,200);
points = getHarrisPoints(im,500,0.05);
imshow(im);
axis on;
hold on;
plot(points(:,2),points(:,1), 'b.', 'MarkerSize', 5, 'LineWidth', 2);


% %% 2.1
% dicRan = load('distionaryRandom.mat').dictionaryRandom;
% dicHar = load('distionaryHarris.mat').dictionaryHarris;
% filerBank = createFilterBank();
% % imshow(label2rgb(getVisualWords(im, filterBank, dicRan)));
% imshow(label2rgb(getVisualWords(im, filterBank, dicHar)));
% % imshow(im);