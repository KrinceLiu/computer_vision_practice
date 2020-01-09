function plot_image()
    %parameters
    sigma     = 4;%deault2
    threshold = 0.03;%default0.03
    rhoRes    = 4;%default2
    thetaRes  = pi/90;%default pi/90
    nLines    = 50;%default50
    %end of parameters
    
    img = imread('../data/img01.jpg');
    img = double(img) / 255;
    [Im] = myEdgeFilter(img, sigma);   
    [H,rhoScale,thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes);
    [rhos, thetas] = myHoughLines(H, nLines);
    
    imshow(H/max(H(:)));
    axis on;
    hold on;
    for i = 1:length(rhos)
        plot(thetas(i),rhos(i), 'r.', 'MarkerSize', 10, 'LineWidth', 2);
    end
end