function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    input.data = reshape(input.data,h_in,w_in,c,batch_size);
    
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.    
    output.data = zeros([h_out, w_out, c, batch_size]);
    for i = 1:batch_size
        % pad
        temp_input = padarray(input.data(:,:,:,i),[pad pad],0,'both');
        % max pool with stride
        for j = 1:c
            for y = 1:h_out
                for x = 1:w_out
                    temp_area = temp_input(1+(y-1)*stride:(y-1)*stride+k,1+(x-1)*stride:(x-1)*stride+k,j);
                    output.data(y,x,j,i) = max(temp_area,[],'all');
                end
            end
        end
    end
    output.data = reshape(output.data,[],batch_size);
end

