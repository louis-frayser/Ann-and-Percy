import Matrix
import System.Random

{- | The output follows the high-bit of the input.  We want the perceptron
 --  percieve this. -}
training_inputs=[[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]] -- ::[[Float]]
training_outputs=transpose [[0, 1, 1, 0]]::[[Float]]

sigmoid x =  1 / (1 + exp (-x))
sigderiv sx = sx * (1 - sx)

-- | Calculate a new output and weights ("think" function)
out_wout inp win = let out = mmap sigmoid (inp `mmult` win)
                       err = matsub training_outputs out
                       adj = err `hmul` (mmap sigderiv out)
                       wout= madd win ((transpose inp) `mmult` adj)
                    in (out, wout) 

ann :: F -> F -> F -> Int -> (F,F)
ann  trn_in weights trn_out iter =
  let ann' :: F -> F -> Int -> (F,F)
      ann' o w i = if i <= 0 then (o,w) else let (o',w') = out_wout training_inputs w in ann' o' w'  (i - 1)
      (out,weights') = out_wout training_inputs weights
   in ann' out weights' (iter -1)
                   
main = 
  do rx <- getStdGen >>= return . randoms >>= return . take 3 :: IO [Float]
     let synaptic_weights = transpose [ map (\r -> (2 * r) - 1) rx ]
     
     putStrLn $ "Training inputs:\n" ++ show training_inputs ++ "\n\nTraining outputs:\n" ++show training_outputs
     
     putStrLn $ "\nRandom starting synaptic weights:\n" ++ show synaptic_weights
     
     let (out,ws_out) = ann training_inputs synaptic_weights training_outputs 20000
     putStrLn $ "\nWeights after training: " ++ show ws_out ++ "\n\nOutput  after training: " ++ show out

     let (newCase,(newOutput,_)) = ([[1,0,0]], out_wout newCase ws_out)
     putStrLn $ "\nNew Input and Output with trained weights:" ++ show  newCase ++ "=>" ++ show newOutput 
