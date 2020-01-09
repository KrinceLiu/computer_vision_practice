function [] = computeDictionary(imgPaths, alpha, K)
    path_prefix = imgPaths;
    dictionaryHarris = getDictionary(path_prefix, alpha, K, 'harris');
    dictionaryRandom = getDictionary(path_prefix, alpha, K, 'random');
    save('distionaryHarris.mat','dictionaryHarris');
    save('distionaryRandom.mat','dictionaryRandom');

end