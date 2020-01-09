function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;

k = layer.k; % filter size --
pad = layer.pad;
stride = layer.stride;
num = layer.num; % number of filters ?

% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

%% Fill in the code
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape. 

output.height = h_out;
output.width = w_out;
output.channel = num;
output.batch_size = batch_size;

all_weight = param.w;
all_bias = param.b;


data_batch = input.data;


result = zeros([h_out, w_out, num, batch_size]);

for b = 1:batch_size % calculate for 100 data
    
    data = reshape(data_batch(:,b), [h_in, w_in, c]);
    data = padarray(data, [pad pad]);
    [data_h, data_w, ~] = size(data);
    for f = 1:num % for every new filter
        filter = reshape(all_weight(:,f), [k k c]);
        bias = all_bias(f);
        for i = 1:stride:data_h
            for j = 1:stride:data_w
                if (i+k-1 <= data_h && j+k-1 <= data_w)
                    window = data(i:i+k-1, j:j+k-1, :);
                    new_val = sum(window .* filter, 'all') + bias;
                    out_i = ceil(i/stride);
                    out_j = ceil(j/stride);
                    result(out_i, out_j, f, b) = new_val;
                end
            end
        end
    end
end
output.data = reshape(result, [h_out * w_out * num, batch_size]);
end

