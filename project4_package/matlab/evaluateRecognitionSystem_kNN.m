function []  = evaluateRecognitionSystem_kNN()
    
    K = 100;
    path_prefix = '../data/';
    path = load(strcat(path_prefix,'traintest.mat'));
    X_test_path = path.test_imagenames;
    y_test_path = path.test_labels;
    
    max_k = 40;
    total = length(X_test_path);
    accuracy = zeros(max_k,1);
    confusion_matrix = zeros(8,8,max_k);
    distance_method = 'chi2';
    points_methos = 'Harris';
    
    visionHarris = load('visionHarris.mat');
    filterBank = visionHarris.filterBank;
    dictionary = visionHarris.dictionary;
    trainFeatures = visionHarris.trainFeatures;
    trainLabels = visionHarris.trainLabels;
    
    for i = 1:length(X_test_path)
        disp(i);
        temp_path = strcat(path_prefix,X_test_path{i});
        temp_im = imread(temp_path);
        temp_y = y_test_path(i);
        [wordMap] = getVisualWords(temp_im, filterBank, dictionary);
        [ h ] = getImageFeatures(wordMap, K);
        dist = getImageDistance(h,trainFeatures,distance_method);
        for j = 1:max_k
            [xs,index] = sort(dist);
            labels = trainLabels(index(1:j));
            label = mode(labels,'all');
            confusion_matrix(temp_y,label,j) = confusion_matrix(temp_y,label,j)+1;
        end
    end
    for j = 1:max_k
        accuracy(j)= sum(diag(confusion_matrix(:,:,j)))/total;
    end
    plot(1:max_k,accuracy,'-o');
    title('kNN - accuracy');
    xlabel('k');
    ylabel('accuracy');
    save('kNN_confusion_matrix.mat','confusion_matrix','accuracy');
end