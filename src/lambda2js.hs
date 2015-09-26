module Main (main) where

import System.Environment (getArgs)
import System.IO (Handle, hPutStr, stderr, stdout)
import Text.ParserCombinators.Parsec (parse)

import Types
import Parser (source)

main :: IO ()
main = do
    args <- getArgs
    main' args

main' :: [String] -> IO ()
main' ["-h"] = usage stdout
main' []     = main'' "stdin" getContents putStr
main' [x]    = main'' x (readFile x) putStr
main' [x,y]  = main'' x (readFile x) (writeFile y)
main' _      = usage stderr

main'' :: String -> IO String -> (String -> IO ()) -> IO ()
main'' s i o = do
    x <- i
    either print (o . jsRender) (parse source s x)

jsRender :: Source -> String
jsRender = f where
    f = unlines . map g
    g d = name d ++ " = " ++ h (expr d)
    h (Var v) = v
    h (App m n) = h m ++ "(" ++ h n ++ ")"
    h (Abs v m) = "function(" ++ v ++ "){return " ++ h m ++ "}"

usage :: Handle -> IO ()
usage h = hPutStr h $ unlines
    [ "lambda2js - Savage compiler."
    , "Usage: lambda2js [infile [outfile]]"
    ]
