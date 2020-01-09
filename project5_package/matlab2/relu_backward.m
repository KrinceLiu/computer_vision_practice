function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
% input_od = zeros(size(input.data));
diff = zeros(size(input.data));
diff(input.data > 0) = 1;
input_od = diff .* output.diff;

end
