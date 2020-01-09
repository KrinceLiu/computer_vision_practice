function [filterResponses] = extractFilterResponses(I, filterBank)
    [H,W,D] = size(I);
    if D < 3
        I(:,:,2) = I(:,:,1);
        I(:,:,3) = I(:,:,1);
    end
    [I_L,I_a,I_b] = RGB2Lab(I);
    for i = 1:size(filterBank)
        filterResponses(:,:,3*(i-1) + 1) = conv2(I_L,cell2mat(filterBank(i)),'same');
        filterResponses(:,:,3*(i-1) + 2) = conv2(I_a,cell2mat(filterBank(i)),'same');
        filterResponses(:,:,3*(i-1) + 3) = conv2(I_b,cell2mat(filterBank(i)),'same');
    end
        
end