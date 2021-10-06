{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell   #-}

{-# OPTIONS_GHC -fno-warn-identities              #-}
{-# OPTIONS_GHC -fno-warn-unused-local-binds      #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns     #-}
{-# OPTIONS_GHC -fno-warn-incomplete-uni-patterns #-}

module MergeSort where

import           PlutusCore.Default
import qualified PlutusTx           as Tx
import           PlutusTx.Prelude   as Tx
import qualified UntypedPlutusCore  as UPLC

{-# INLINABLE drop #-}
drop :: Integer -> [a] -> [a]
drop _ [] = []
drop n l@(_:xs) =
    if n <= 0 then l
    else drop (n-1) xs

{-# INLINABLE merge #-}
merge :: [Integer] -> [Integer] -> [Integer]
merge [] ys = ys
merge xs [] = xs
merge xs1@(x:xs) ys1@(y:ys) =
    if x <= y
    then x:(merge xs ys1)
    else y:(merge xs1 ys)

{-# INLINABLE mergeSort #-}
mergeSort :: [Integer] -> [Integer]
mergeSort xs =
    if n <= 1 then xs
    else merge (mergeSort (take n2 xs)) (mergeSort (drop n2 xs))
        where
          n = length xs
          n2 = n `divide` 2

{- I think this is approximately the worst case.  A lot of the work happens in
   merge and this should make sure that the maximal amount of interleaving is
   required there.  If we merge [1,2,3,4] and [5,6,7,8] then we get to the case
   merge [] [5,6,7,8] which can return immediately; this function at n=8 gives us
   [1,5,3,7,2,6,4,8], which leads to merge [1,3,5,7] [2,4,6,8], and we have to go
   all the way to 1:2:3:4:5:6:7:(merge [] [8]) to merge those. -}
msortWorstCase :: Integer -> [Integer]
msortWorstCase n = f [1..n]
    where f ls =
              let (left, right) = unzip2 ls [] []
              in case (left, right) of
                   ([],_) -> right
                   (_,[]) -> left
                   _      -> f left ++ f right
          unzip2 l lacc racc =
              case l of
                []         -> (reverse lacc, reverse racc)
                [a]        -> (reverse(a:lacc), reverse racc)
                (a:b:rest) -> unzip2 rest (a:lacc) (b:racc)

mkMergeSortTerm :: [Integer] -> UPLC.Term UPLC.NamedDeBruijn DefaultUni DefaultFun ()
mkMergeSortTerm l =
    let (UPLC.Program _ _ code) = Tx.getPlc $ $$(Tx.compile [|| mergeSort ||]) `Tx.applyCode` Tx.liftCode l
    in code

mkWorstCaseMergeSortTerm :: Integer -> UPLC.Term UPLC.NamedDeBruijn DefaultUni DefaultFun ()
mkWorstCaseMergeSortTerm = mkMergeSortTerm . msortWorstCase
