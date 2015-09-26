module Parser (source) where

import Types

import Control.Monad (void)
import Text.ParserCombinators.Parsec

ndSepBy1 :: GenParser a b c -> GenParser a b d -> GenParser a b [c]
ndSepBy1 p sep = do
    x  <- p
    xs <- try (sep >> ndSepBy1 p sep) <|> return []
    return $ x:xs

brace :: GenParser Char a b -> GenParser Char a b
brace = between lbrace rbrace where
    lbrace = char '('
    rbrace = char ')'

mySpace :: Parser Char
mySpace = char ' '

mySpaces :: Parser ()
mySpaces = void $ many1 mySpace

source :: Parser Source
source = do
    many newline
    x <- ndSepBy1 definition (many1 newline)
    many newline
    eof
    return x

definition :: Parser Definition
definition = do
    i <- variable
    mySpaces
    char '='
    mySpaces
    l <- lambda
    return $ Def i l

lambda :: Parser Lambda
lambda = fmap (foldl1 App) lambda'

lambda' :: Parser [Lambda]
lambda' = ndSepBy1 lambdaBase mySpace

lambdaBase :: Parser Lambda
lambdaBase = var <|> brace lambda <|> abstr

var :: Parser Lambda
var = fmap Var variable

variable :: Parser VarType
variable = do
    x <- letter
    s <- many (letter <|> digit)
    return $ x:s

abstr :: Parser Lambda
abstr = do
    char '\\' <?> "lambda"
    mySpace
    vs <- ndSepBy1 variable mySpace
    mySpace
    char '.'
    mySpace
    l <- lambda
    return $ foldr Abs l vs

