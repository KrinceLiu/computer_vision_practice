function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
    
    %input
    [m,n] = size(Im); 
%     threshold = 0.03;
%     rhoRes    = 2;
%     thetaRes  = pi/90;
    
    %usage
    rho = m+n;
    theta = 2*pi;
    
    %output
    rhoScale = 0:rhoRes:rho;
    thetaScale = 0:thetaRes:theta;
    H = zeros(length(rhoScale),length(thetaScale));    

    
    for i = 1:m
        for j = 1:n
            if Im(i,j) > threshold
                H = drawInHough(H,i,j,rhoScale, thetaScale);
            end
        end
    end
    
    
end
        
    
function H = drawInHough(H,i,j,rhoScale, thetaScale)
    for t = 1:length(thetaScale)
        theta_temp = thetaScale(t);
        rho_temp = j * cos(theta_temp) + i*sin(theta_temp);
        
        if 0 <= rhoScale(1) && rho_temp <= rhoScale(end)
            rho_index = round(1 + rho_temp/rhoScale(2)); 
            if 1 <= rho_index && rho_index <= length(rhoScale)
                H(rho_index,t) = H(rho_index,t) + 1;
            end
        end
    end

end
