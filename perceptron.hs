import Matrix
import System.Random

training_inputs=[[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]] -- ::[[Float]]
training_outputs=transpose [[0, 1, 1, 0]]::[[Float]]

sigmoid x =  1 / (1 + exp (-x))
sigderiv sx = sx * (1 - sx)

ann :: F -> F -> F -> Int -> F
ann  trn_in weights trn_out iter =
  let outf w_in   =  mmap sigmoid (trn_in `mmult` w_in)
      errf out = matsub trn_out out
      adjf out err =  err `hmul` (mmap sigderiv out)
      weightf w adj = madd w ((transpose trn_in) `mmult` adj)
      out_wout w0 = let out = outf w0; err = errf out; adj=adjf out err; w = weightf w0 adj in (out, w)
      
      ann' :: F -> F -> Int -> F
      ann' o w i = if i <= 0 then o else let (o',w') = out_wout w in ann' o' w'  (i - 1)
      (out,weights') = out_wout weights
   in ann' out weights' (iter -1)
                   
main = 
  do rx <- getStdGen >>= return . randoms >>= return . take 3 :: IO [Float]
     let synaptic_weights = transpose [ map (\r -> (2 * r) - 1) rx ]
     
     putStrLn "Inputs:"
     print training_inputs
     
     putStrLn "Random starting synaptic weights:"
     putStrLn $ show synaptic_weights
     
     let result = "\nOutput after training:\n" ++ show ( ann training_inputs synaptic_weights training_outputs 20000)
     putStrLn  result
