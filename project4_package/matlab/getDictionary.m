function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    %  get data
    k = 0.05;
    path_prefix = imgPaths;
    path = load(strcat(path_prefix,'traintest.mat'));
    X_train_path = path.train_imagenames;
    y_train_path = path.train_labels;
%     X_test_path = path.test_imagenames;
%     y_test_path = path.test_labels;
    % get bank
    filterBank = createFilterBank();
    % X
    X = [];
    % extract data
    for i=1:length(X_train_path)
        disp(i);
        % image path
        temp_path = strcat(path_prefix,X_train_path{i});
        % read image
        temp_im = imread(temp_path);
        % read label
        temp_y = y_train_path(i);
        % filter responses (# = 60)
        filterResponses = extractFilterResponses(temp_im,filterBank);
        % sample points
        if strcmp(method,'random')
           temp_points = getRandomPoints(temp_im,alpha); 
        else
           temp_points = getHarrisPoints(temp_im,alpha,k);  
        end
        % loop over points
        for j = 1:alpha
            % loop over filters
            temp_X = filterResponses(temp_points(j,1),temp_points(j,2),:);
            temp_X = temp_X(:)';
            X = [X;temp_X];
        end
    end
    
    % train cluster
    [~, dictionary] = kmeans(X, K, 'EmptyAction', 'drop');
end
