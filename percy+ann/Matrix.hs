module Matrix (F,hmul, mmult, transpose,  mdec, mmap, madd, matsub)
where
import Data.List

type F = [[Float]]

mmult :: Num a => [[a]] -> [[a]] -> [[a]] 
mmult a b = [ [ sum $ zipWith (*) ar bc | bc <- (transpose b) ] | ar <- a ]

hmul :: Num a => [[a]] -> [[a]] -> [[a]] -- Hardamard
hmul (m:ms) (n:ns) = (zipWith (*) m n):(hmul ms ns)
hmul _ _ = []

mmap ::  (Num a, Num b ) => (a -> b) -> [[a]] -> [[b]]
mmap f mat@(v:vs) = (map f v):(mmap f vs)
mmap _ _ = []

mdec :: Num a => [[a]]->[[a]]
mdec a = mmap (\x ->  -x) a

mapp2 :: Num a => (a -> a -> a) -> [[a]] -> [[a]] -> [[a]] -- Hardamard
mapp2 f (m:ms) (n:ns) = (zipWith f  m n):(mapp2 f ms ns)
mapp2 _ _ _ = []

matsub,madd :: [[Float]] -> [[Float]] -> [[Float]]
madd = mapp2 (+)
matsub = mapp2 (-)
