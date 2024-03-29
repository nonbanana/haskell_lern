module HW4 where

iterApp :: Integral i => (t -> t) -> i -> t -> t
iterApp f n x
   | n < 0      = error "must bigger then 0"
   | n == 0     = x
   | otherwise  = iterApp f (n - 1) (f x)  

iterApp' :: Integral i => (t -> t) -> i -> t -> t
iterApp' f n x
   | n < 0      = error "must bigger then 0"
   | n == 0     = x
   | otherwise  = f (iterApp' f (n - 1) x)

iterApp'' :: Integral i => (t -> t) -> i -> t -> t
iterApp'' f n 
   | n < 0      = error "must bigger then 0"
   | n == 0     = id
   | otherwise  = f . (iterApp'' f (n - 1))   
      




---------------------------------------------------------
-- SECTION 2


progress1 :: Integral i => (t -> t) -> i -> t -> [t]
progress1 f n x
    | n <  0     =  error "Cannot apply negative times!"
    | n == 0     =  [x] 
    | otherwise  =  (progress1 f (n - 1) x) ++ [(iterApp f n x)]


progress2 :: Integral i => (t -> t) -> i -> t -> [t]
progress2 f n x
    | n <  0     =  error "Cannot apply negative times!"
    | n == 0     =  [x]
    | otherwise  =  x : (progress2 f (n - 1) (f x))


progress3 :: Integral i => (t -> t) -> i -> t -> [t]
progress3 f n x
    | n <  0     =  error "Cannot apply negative times!"
    | n == 0     =  [x]
    | otherwise  =  x : map f (progress3 f (n - 1) x)
    -- x : [f e | e <- progress3 f (n-1) x]

progress4 :: Integral i => (t -> t) -> i -> t -> [t]
progress4 f n x
    | n <  0     =  error "Cannot apply negative times!"
    | otherwise  = map (\z -> iterApp f z x) [0..n]


progress :: Integral i => (t -> t) -> i -> t -> [t]
progress = progress4


-- progress0 :: Integral i => (t -> t) -> i -> t -> [t]   -- incorrect
progress0 :: (t -> t) -> Int -> t -> [t]                  --   correct
progress0 f n x  =  take (n+1) (iterate f x)

progress0' :: (t -> t) -> Int -> t -> [t]
progress0' f n x
    | n < 0      =  error "Cannot apply negative times!"
    | otherwise  =  take (n+1) (iterate f x)   