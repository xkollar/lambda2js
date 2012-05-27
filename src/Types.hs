module Types where

type VarType = String

data Lambda
    = Var VarType
    | App Lambda  Lambda
    | Abs VarType Lambda
    deriving Show

data Definition = Def
    { name :: String
    , expr :: Lambda
    } deriving Show

type Source = [Definition]

