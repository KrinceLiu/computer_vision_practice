function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here
    [m,n] = size(H);
    
    %maximal suppression
    for i = 2:m-1
        for j = 2:n-1
            sub_matrix = H(i-1:i+1,j-1:j+1);
            sub_matrix(2,2) = sub_matrix(2,1);
            if H(i,j) <= max(max(sub_matrix))
                H(i,j) = 0;
            end
        end
    end
    
    H_array = reshape(H',1,[]);
    H_array_sorted = sort(H_array,'descend');
    H_array_highest = H_array_sorted(1:nLines);
    rhos = 1:nLines;
    thetas = 1:nLines;
    
    for i = 1:nLines
        [row,column] = find(H == H_array_highest(i));
        rhos(i) = row(1);
        thetas(i) = column(1);
    end
    
    rhos = reshape(rhos,nLines,1);
    thetas = reshape(thetas,nLines,1);
    
end
        