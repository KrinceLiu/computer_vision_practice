function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

input_height = size(param.w,1);
input_width = size(param.w,2);
output_height = output.height;
batch_size = input.batch_size;
% param_grad.w: input_size*output_size
% output.diff:  output_size*batch_size


% param_grad.w & param_grad.b
param_grad.b = zeros(size(param.b));
param_grad.w = zeros(size(param.w));
for b = 1:batch_size 
    temp_error = output.diff(:,b);
    temp_input = repmat(input.data(:,b),[1,output_height]);
    param_grad.w = param_grad.w + temp_input * diag(temp_error);
    param_grad.b = param_grad.b + ones(1,output_height) * diag(temp_error);
end

% input_od
input_od = zeros(input_height,batch_size);
for b = 1:batch_size
    for i = 1:input_height
        input_od(i,b) = param.w(i,:) * output.diff(:,b);
    end
end


end