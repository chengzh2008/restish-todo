module Main where

import           Data.Semigroup      ((<>))
import           Lib
import           Options.Applicative (ParserInfo, CommandFields, Mod, Parser, argument, command, execParser,
                                      idm, info, str, subparser)
import Control.Monad (join)

type Host = String
type Port = Integer

data Command = Serve Host Port

newtype Options = Options { cmd:: Command }

-- | Start up the server and serve request
server :: IO ()
server = putStrLn "Server starting..."

monitor :: IO ()
monitor = putStrLn "Monitoring..."

-- | CLI options parser
opts :: Parser (IO ())
opts = subparser commands
  where
    serverCmd :: ParserInfo (IO ())
    serverCmd = info (pure server) idm

    monitorCmd :: ParserInfo (IO ())
    monitorCmd = info (pure monitor) idm

    commands :: Mod CommandFields (IO ())
    commands = command "server" serverCmd
               <> command "monitor" monitorCmd




main :: IO ()
main = join $ execParser parser
  where
    parser :: ParserInfo (IO ())
    parser = info opts idm
