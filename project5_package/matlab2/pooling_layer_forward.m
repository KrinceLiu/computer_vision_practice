function [output] = pooling_layer_forward(input, layer)
    
    % the pooling layer does not have weight so no params
    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k; % filter size ?
    pad = layer.pad; % padding
    stride = layer.stride; % stride for the filter

    
    % ((n + 2p - f)/ s ) + 1
    h_out = (h_in + 2*pad - k) / stride + 1; % output height
    w_out = (w_in + 2*pad - k) / stride + 1; % output width
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c; % volumn channels number is the same as the input
    output.batch_size = batch_size;

    %%
    % Replace the following line with your implementation.
%     output.data = zeros([h_out, w_out, c, batch_size]);
    
    
    result = zeros([h_out, w_out, c, batch_size]);
    data_batch = input.data;
    for b = 1:batch_size
        data = reshape(data_batch(:,b), [h_in, w_in, c]);
        for i = 1:stride:h_in
            for j = 1:stride:w_in

                volumn = data(i:i+k-1, j:j+k-1, :);
                out_i = ceil(i/stride);
                out_j = ceil(j/stride);

                result(out_i, out_j, :, b) = max(volumn, [], [1 2]);
            end
        end
    end
    output.data = reshape(result, [h_out * w_out * c, batch_size]);
end

