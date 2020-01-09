function [] = evaluateRecognitionSystem_NN()
    alpha = 50;
    K = 100;
    path_prefix = '../data/';
    path = load(strcat(path_prefix,'traintest.mat'));
    X_test_path = path.test_imagenames;
    y_test_path = path.test_labels;

    
    total = length(X_test_path);
    confusion_matrix_euc_har = zeros(8,8);
    confusion_matrix_chi_har = zeros(8,8);
    confusion_matrix_euc_ran = zeros(8,8);
    confusion_matrix_chi_ran = zeros(8,8);
    %% Harris Dictionary
    visionHarris = load('visionHarris.mat');
    filterBank = visionHarris.filterBank;
    dictionary = visionHarris.dictionary;
    trainFeatures = visionHarris.trainFeatures;
    trainLabels = visionHarris.trainLabels;
    for i=1:length(X_test_path)
        disp(i);
        temp_path = strcat(path_prefix,X_test_path{i});
        temp_im = imread(temp_path);
        temp_y = y_test_path(i);
        [wordMap] = getVisualWords(temp_im, filterBank, dictionary);
        [ h ] = getImageFeatures(wordMap, K);
        % Euclidean Distance
        dist = getImageDistance(h,trainFeatures,'euclidean');
        [Value,Index] = min(dist);
        temp_label = trainLabels(Index);
        confusion_matrix_euc_har(temp_y,temp_label) = confusion_matrix_euc_har(temp_y,temp_label)+1;
        % Chi2 Distance
        dist = getImageDistance(h,trainFeatures,'chi2');
        [Value,Index] = min(dist);
        temp_label = trainLabels(Index);
        confusion_matrix_chi_har(temp_y,temp_label) = confusion_matrix_chi_har(temp_y,temp_label)+1;
    end

    %% Random Dictionary
    visionRandom = load('visionRandom.mat');
    filterBank = visionRandom.filterBank;
    dictionary = visionRandom.dictionary;
    trainFeatures = visionRandom.trainFeatures;
    trainLabels = visionRandom.trainLabels;
    for i=1:length(X_test_path)
        disp(i);
        temp_path = strcat(path_prefix,X_test_path{i});
        temp_im = imread(temp_path);
        temp_y = y_test_path(i);
        [wordMap] = getVisualWords(temp_im, filterBank, dictionary);
        [ h ] = getImageFeatures(wordMap, K);
        % Euclidean Distance
        dist = getImageDistance(h,trainFeatures,'euclidean');
        [Value,Index] = min(dist);
        temp_label = trainLabels(Index);
        confusion_matrix_euc_ran(temp_y,temp_label) = confusion_matrix_euc_ran(temp_y,temp_label)+1;
        % Chi2 Distance
        dist = getImageDistance(h,trainFeatures,'chi2');
        [Value,Index] = min(dist);
        temp_label = trainLabels(Index);
        confusion_matrix_chi_ran(temp_y,temp_label) = confusion_matrix_chi_ran(temp_y,temp_label)+1;
    end
    
    accuracy_euc_har = sum(diag(confusion_matrix_euc_har))/total;
    accuracy_chi_har = sum(diag(confusion_matrix_chi_har))/total;
    accuracy_euc_ran = sum(diag(confusion_matrix_euc_ran))/total;
    accuracy_chi_ran = sum(diag(confusion_matrix_chi_ran))/total;
    save('accuracys.mat','confusion_matrix_euc_har','confusion_matrix_chi_har','confusion_matrix_euc_ran','confusion_matrix_chi_ran');
    disp(accuracy_euc_har);
    disp(accuracy_chi_har);
    disp(accuracy_euc_ran);
    disp(accuracy_chi_ran);
    
end