const math = require('mathjs')
const hmul = math.dotMultiply, sub = math.subtract, mul=math.multiply, tr=math.transpose,rmap=math.map
const { exp, random,add } = require( "mathjs");
const print=console.log;
// -----------------------------------
const training_set_inputs = [[0, 0, 1],[1, 1, 1],[ 1, 0, 1],[ 0, 1, 1]]
const training_set_outputs = tr([[0, 1, 1, 0]])
print("training inputs:",training_set_inputs)
print("training outputs", training_set_outputs)

// random.seed(1)
synaptic_weights = tr([rmap([1,1,1], (x) => 2 *random(x)-1)])
print(synaptic_weights);
			    
for(let iterator = 1; iterator <= 20000; iterator++){
    output = rmap(mul(training_set_inputs,synaptic_weights), (x) => 1/(1+ exp(-x)));
    
    synaptic_weights=add(synaptic_weights,
			 mul(tr(training_set_inputs),
			     hmul(sub(training_set_outputs,output),
				  hmul(output,sub(1, output)))))
}
print("Percetpron out: " , output)

print("\nFinal weights: " , synaptic_weights)


print( "Output from novel input [1 0 0 ] => " ,
     rmap(mul([[1,0,0]],synaptic_weights), (x) => 1/(1+ exp(-x))))
