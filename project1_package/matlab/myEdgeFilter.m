function [img1] = myEdgeFilter(img0, sigma)

    %smooth with gaussian
    [m,n] = size(img0);
    sigma = sigma;
    hsize = 2 * ceil(3 * sigma) + 1;
    h = fspecial('gaussian',hsize,sigma);
    img0_smooth = myImageFilter(img0,h);

    %horizontal sobel
    h_sobel_x = reshape([1,0,-1,2,0,-2,1,0,-1],3,3)';
    imgx = myImageFilter(img0_smooth,h_sobel_x);

    %vertical sobel
    h_sobel_y = reshape([1,0,-1,2,0,-2,1,0,-1],3,3);
    imgy = myImageFilter(img0_smooth,h_sobel_y);

    %gradient amplitude
    ga = sqrt((imgx .* imgx) + (imgy .* imgy));
    
    %gradient direction
    gd = atan(imgy ./ imgx);
  
    %no maximum supression
    ga_nms = ga;
    for i = 2:m-1
        for j = 2:n-1
            %0
            if (-pi/8 <= gd(i,j) && gd(i,j) <= pi/8) || (pi*7/8 <= gd(i,j) && gd(i,j) <= pi) || (-pi <= gd(i,j) && gd(i,j)<= -pi*7/8)
                if ga(i,j) < ga(i,j+1) || ga(i,j) < ga(i,j-1)
                    ga_nms(i,j) = 0;
                end
            end
            %45
            if ( pi*1/8 <= gd(i,j) && gd(i,j) <= pi*3/8) || ( -pi*7/8 <= gd(i,j) && gd(i,j) <= -pi*5/8)
                if ga(i,j) < ga(i+1,j+1) || ga(i,j) < ga(i-1,j-1)
                    ga_nms(i,j) = 0;
                end
            end
            %90
            if ( pi*3/8 <= gd(i,j) && gd(i,j) <= pi*5/8) || ( -pi*5/8 <= gd(i,j) && gd(i,j) <= -pi*3/8)
                if ga(i,j) < ga(i+1,j) || ga(i,j) < ga(i-1,j)
                    ga_nms(i,j) = 0;
                end
            end
            %135
            if ( pi*5/8 <= gd(i,j) && gd(i,j) <= pi*7/8) || ( -pi*3/8 <= gd(i,j) && gd(i,j) <= -pi*1/8)
                if ga(i,j) < ga(i-1,j+1) || ga(i,j) < ga(i+1,j-1)
                    ga_nms(i,j) = 0;
                end
            end
            
        end
    end 
   
    img1= ga_nms;
end
                
        
        
