import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# "*" is the Hadamard product
def sigmoid_derivative(sx):
    return sx * (1 - sx)

training_inputs = np.array([[0,0,1],
                            [1,1,1],
                            [1,0,1],
                            [0,1,1]])

training_outputs = np.array([[0,1,1,0]]).T

"""np.random.seed(1) # Not used"""

synaptic_weights = 2 *  np.random.random((3,1)) - 1

print("Training inputs:",  training_inputs)
print("Training outputs:", training_outputs)
print("Random starting synaptic weights:", synaptic_weights)

input_layer = training_inputs

for iteration in range(20000):

    # np.dot is regular matrix* in this case
    output = sigmoid(np.dot(input_layer,synaptic_weights))

    error = training_outputs - output
    # '*' is the Hadamard product
    adjustments = error * sigmoid_derivative(output)
    #print("*\nerror\n", error, "\nderiv\n", adjustments, "\n\n")

    synaptic_weights += np.dot(input_layer.T,  adjustments)
    

print("Synaptic weights after training:", synaptic_weights)

print("Outputs after training", output)

novelout = sigmoid(np.dot([1,0,0],synaptic_weights))

print("Output for novel input: [ 1,0,0 ] => ", novelout)
