#-*-julia-*-
const training_inputs = layer1 = [0 0 1 ;1 1 1 ;1 0 1; 0 1 1]
println("Training inputs"); display(training_inputs)

const training_outputs = [0; 1; 1; 0]
println("\nTraining Outputs"); display(training_outputs)

weights = 2 .* rand(3) .- 1
println("\nInitial random weights"); display(weights)
for iterator = 1:20000
    global output =  map(x -> 1 / (1 + exp(-x)), layer1 * weights)  
    error = training_outputs - output
    adjustments = error .* (1 .- output)
    global weights += transpose(layer1) * adjustments
end

println("--\n\nWeights after training: "); display(weights)
println("\n\nOutputs after trainging");    display(output)
println("\n")