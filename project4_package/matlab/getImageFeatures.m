function [ h ] = getImageFeatures(wordMap, dictionarySize)
    h = histogram(wordMap,'BinEdges',1:dictionarySize+1).Values;
    h = h/norm(h,1);
end