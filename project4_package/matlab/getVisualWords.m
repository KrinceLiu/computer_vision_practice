function [wordMap] = getVisualWords(I, filterBank, dictionary)
%     [H,W,D] = size(I);
%     wordMap = zeros(H,W);
    filterResponses = extractFilterResponses(I,filterBank);
%     for i = 1:H
%         for j = 1:W
%             temp_pixel = filterResponses(i,j,:);
%             temp_pixel = temp_pixel(:)';
%             [D,Index] = pdist2(dictionary,temp_pixel,'euclidean','Smallest',1);
%             wordMap(i,j) = Index;
%         end
%     end
    [f_H,f_W,f_D] = size(filterResponses);
    filterResponses = reshape(filterResponses,f_H*f_W,f_D);
    [V,Index] = pdist2(dictionary,filterResponses,'euclidean','Smallest',1);
    wordMap = reshape(Index,f_H,f_W);
end