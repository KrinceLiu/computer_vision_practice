function [] = buildRecognitionSystem()

    %% parameters
    path_prefix = '../data/';
    alpha = 50;
    K = 100;
    
    filterBank = createFilterBank();
    path = load(strcat(path_prefix,'traintest.mat'));
    X_train_path = path.train_imagenames;
    y_train_path = path.train_labels;
    X_test_path = path.test_imagenames;
    y_test_path = path.test_labels;
    
%     computeDictionary(path_prefix, alpha, K);
    
    %% Harris File
    [dictionary] = load('distionaryHarris.mat').dictionaryHarris;
    % X,y
    trainLabels = [];
    trainFeatures = [];
    % extract data
    for i=1:length(X_train_path)
        disp(i);
        disp(length(X_train_path));
        % image path
        temp_path = strcat(path_prefix,X_train_path{i});
        % read image
        temp_im = imread(temp_path);
        % read label
        temp_y = y_train_path(i);
        % wordMap
        [wordMap] = getVisualWords(temp_im, filterBank, dictionary);
%         [wordMap] = load(strrep(temp_path,'.jpg','.mat')).wordMap;
        % hist 
        [ h ] = getImageFeatures(wordMap, K);
        % extend 
        trainFeatures = [trainFeatures;h];
        trainLabels = [trainLabels;temp_y];
    end
    save('visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels');
    
    
    %% Random File
    [dictionary] = load('distionaryRandom.mat').dictionaryRandom;
    % X,y
    trainLabels = [];
    trainFeatures = [];
    % extract data
    for i=1:length(X_train_path)
        disp(i);
        disp(length(X_train_path));
        % image path
        temp_path = strcat(path_prefix,X_train_path{i});
        % read image
        temp_im = imread(temp_path);
        % read label
        temp_y = y_train_path(i);
        % wordMap
        [wordMap] = getVisualWords(temp_im, filterBank, dictionary);
        % hist 
        [ h ] = getImageFeatures(wordMap, K);
        % extend 
        trainFeatures = [trainFeatures;h];
        trainLabels = [trainLabels;temp_y];
    end
    save('visionRandom.mat','dictionary','filterBank','trainFeatures','trainLabels');
    
end