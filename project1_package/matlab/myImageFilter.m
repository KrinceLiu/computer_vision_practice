function [img1] = myImageFilter(img0, h)
    %get image size
    [m2,n2] = size(h);
    [m1,n1] = size(img0);
    
    %padding
    m2_f = floor(m2/2);
    n2_f = floor(n2/2);
    img_pad = padarray(img0,[m2_f,n2_f],'replicate','both');
    
    %convolution
    img1 = img0;
    for i = 1:m1
        for j = 1:n1
            vec_img = reshape(img_pad(i:i+m2_f*2,j:j+n2_f*2)',1,[]);
            vec_h = flip(reshape(h',[],1));
            img1(i,j) = dot(vec_img,vec_h);
        end
    end

end

