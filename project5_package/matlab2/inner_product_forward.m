function [output] = inner_product_forward(input, layer, param)

    d = size(input.data, 1);
    k = size(input.data, 2); % batch size
    n = size(param.w, 2); % or == layer.num

    % Replace the following line with your implementation.
%     output.data = zeros([n, k]);
    
    data_batch = input.data; % size 800 x 100
    w = param.w; % size 800 x 500
    
    w = w.'; % 500 x 800
    bias = param.b; % 1 x 500
    bias = bias.'; % 500 x 1
    bias = repmat(bias,1, k); % 500 x batch_size
    
    output.data = w * data_batch + bias; % 500 x 100
    output.height = n;
    output.width = 1;
    output.batch_size = k;
    output.channel = 1;

end
