%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet_2.mat

% load images and corp  to  28*28 * 5
% a = imread('my_images/test_2.jpg');
% [J, rect] = imcrop(a);
% imshow(J)
my_images = zeros(28*28,100);
tempImage = reshape(rgb2gray(imresize(imread('my_images/test_1.jpg'),[28,28])),[],1);
my_images(:,1) = tempImage;
tempImage = reshape(rgb2gray(imresize(imread('my_images/test_2.jpg'),[28,28])),[],1);
my_images(:,2) = tempImage;
tempImage = reshape(rgb2gray(imresize(imread('my_images/test_3.jpg'),[28,28])),[],1);
my_images(:,3) = tempImage;
tempImage = reshape(rgb2gray(imresize(imread('my_images/test_4.jpg'),[28,28])),[],1);
my_images(:,4) = tempImage;
tempImage = reshape(rgb2gray(imresize(imread('my_images/test_5.jpg'),[28,28])),[],1);
my_images(:,5) = tempImage;
% my_images = double(my_images);
my_images = 255 - my_images;

[output, P] = convnet_forward(params, layers, my_images);
[~,ytest_result] = max(P,[],1);
% disp(P(:,1:5))
disp(ytest_result(1:5))
