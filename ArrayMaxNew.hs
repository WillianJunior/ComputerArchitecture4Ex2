------------------------------------------------------------------------
--  ArrayMax: machine language program for the M1 architecture
------------------------------------------------------------------------

{- A machine language program for the M1 architecture that searches an
array of natural numbers for the maximal element.  The loop terminates
when a negative element is encountered.  To compile and execute the
program (file FindMax.hs), enter the following commands:

  ghc --make ArrayMax
  ./ArrayMax
-}

module Main where
import M1run

main :: IO ()
main = run_M1_program arraymax 10000

------------------------------------------------------------------------

arraymax :: [String]
arraymax =
-- Machine Language  Addr    Assembly Language     Comment
-- ~~~~~~~~~~~~~~~~  ~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 [
                  -- 0000 ; ArrayMax: find the maximum element of an array
                  -- 0000
                  -- 0000 ; The program is given
                  -- 0000 ;   *  a natural number n, assume n>0
                  -- 0000 ;   *  an n-element array x[0], x[1], ..., x[n-1]
                  -- 0000 ;  It calculates
                  -- 0000 ;   * max = the maximum element of x
                  -- 0000
                  -- 0000 ; Since n>0, the array x contains at least one
                  -- 0000 ;  element, and a maximum element is guaranteed
                  -- 0000 ;  to exist.
                  -- 0000
                  -- 0000 ; program ArrayMax
                  -- 0000 ;   max := x[0]
                  -- 0000 ;   for i := 1 to n-1 step 1
                  -- 0000 ;       if x[i] > max
                  -- 0000 ;         then max := x[i]
                  -- 0000
                  -- 0000 ; Register usage
                  -- 0000 ;   R1 = constant 1
                  -- 0000 ;   R2 = n
                  -- 0000 ;   R3 = i
                  -- 0000 ;   R4 = max
                  -- 0000
                  -- 0000 ; Initialise
                  -- 0000
  "f100", "0001", -- 0000 start lea   R1,1[R0]      ; R1 = constant 1
  "f201", "0016", -- 0002       load  R2,n[R0]      ; R2 = n
  "f300", "0001", -- 0004       lea   R3,1[R0]      ; R3 = i = 1
  "f401", "0018", -- 0006       load  R4,x[R0]      ; R4 = max = &x[0]
                  -- 0008
                  -- 0008 ; Top of loop, determine whether to remain in loop
                  -- 0008
                  -- 0008 loop
  "4532",         -- 0008       cmplt R5,R3,R2      ; R5 = (i<n)
  "f504", "0013", -- 0009       jumpf R5,done[R0]   ; if i>=n then goto done
                  -- 000b
                  -- 000b ; if x[i] > max
                  -- 000b
  "f537", "0018", -- 000b       loadxi  R5,x[R3]      ; R5 = x[i], i++
  "6654",         -- 000d       cmpgt R6,R5,R4      ; R6 = (x[i]>max)
  "f604", "0008", -- 000e       jumpf R6,loop[R0]   ; if &x[i]<=max, goto loop
                  -- 0010             
                  -- 0010 ; then max := x[i]
                  -- 0010             
  "0450",         -- 0010       add   R4,R5,R0      ; max := x[i]
                  -- 0011
                  -- 0011 ; Bottom of loop
                  -- 0011
  "f003", "0008", -- 0011        jump  loop[R0]     ; go to top of loop
                  -- 0013             
                  -- 0013 ; Exit from loop
                  -- 0013
  "f402", "0017", -- 0013 done   store R4,max[R0]   ; max = R4
  "d000",         -- 0015        trap  R0,R0,R0     ; terminate
                  -- 0016
                  -- 0016 ; Data area
  "0006",         -- 0016 n        data   6
  "0000",         -- 0017 max      data   0
  "0012",         -- 0018 x        data  18
  "0003",         -- 0019          data   3
  "0015",         -- 001a          data  21
  "fffe",         -- 001b          data  -2
  "0028",         -- 001c          data  40
  "0019"          -- 001d          data  25
 ]

------------------------------------------------------------------------
