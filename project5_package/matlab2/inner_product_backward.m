function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
param_grad.b = zeros(size(param.b));
param_grad.w = zeros(size(param.w));

batch_size = output.batch_size;

loss_out = output.diff;
data_in = input.data;

w_loss_batch = zeros(size(param.w));
b_loss_batch = zeros(size(param.b));
for i=1:batch_size
    diff = loss_out(:,i); % 500 x 1
    diff = diff.'; % 1 x 500
    data = data_in(:,i); % 800 x 1
    w_loss = data * diff; % 800 x 500
    w_loss_batch = w_loss_batch + w_loss;
    b_loss_batch = b_loss_batch + diff;
end
param_grad.w = w_loss_batch;
param_grad.b = param.b;

input_od = param.w * output.diff;

end
