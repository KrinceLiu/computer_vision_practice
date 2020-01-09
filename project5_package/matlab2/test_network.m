%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet_2.mat

%% Testing the network
% Modify the code to get the confusion matrix
confusion_matrix = zeros(10,10);
for i=1:100:size(xtest, 2)
% for i=1:100:200
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~,ytest_result] = max(P,[],1);
    for j = 1:100
        confusion_matrix(ytest(1,j),ytest_result(1,j)) = confusion_matrix(ytest(1,j),ytest_result(1,j)) +1;
    end
end
save('test_network', 'confusion_matrix');
accuracy= sum(diag(confusion_matrix),'all')/sum(confusion_matrix,'all');
disp(accuracy);
save('test_network', 'accuracy');