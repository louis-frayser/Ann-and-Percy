octave = "============== percy.m ======================================"
training_inputs = input_layer = [ 0 0 1;  1 1 1;  1 0 1; 0 1 1 ]      
training_outputs = [ 0; 1; 1; 0 ]

sigmoid = @(x) 1 ./ (1 + exp (-x) )
sigderiv = @(sx) sx .* (1 - sx)

synaptic_weights = 2 .* rand(3,1) - 1
# ----------------------------------------------------------
for iterator = iterator = 1:20000
   output = sigmoid(training_inputs * synaptic_weights);
   error  = training_outputs - output;
   adjustments = error .* sigderiv(output);
   synaptic_weights += (transpose(input_layer) *  adjustments);
endfor
# ----------------------------------------------------------
disp ("--\nAfter training...");
synaptic_weights
output

