module Simulator.Lenses
  ( _simulations
  , _actionDrag
  , _evaluationResult
  , _successfulEvaluationResult
  , _lastEvaluatedSimulation
  , _transactionsOpen
  , _blockchainVisualisationState
  , _simulationId
  , _simulationActions
  , _simulationWallets
  , _resultRollup
  , _walletKeys
  ) where

import Chain.Types (State) as Chain
import Cursor (Cursor)
import Data.Either (Either)
import Data.Json.JsonTuple (JsonTuple)
import Data.Lens (Lens', Traversal', _Right)
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Lens.Record (prop)
import Data.Maybe (Maybe)
import Data.Symbol (SProxy(..))
import Network.RemoteData (_Success)
import Playground.Types (ContractCall, EvaluationResult, PlaygroundError, Simulation, SimulatorWallet)
import Plutus.V1.Ledger.Crypto (PubKeyHash)
import Prelude ((<<<))
import Schema.Types (FormArgument)
import Simulator.Types (State)
import Types (WebData)
import Wallet.Emulator.Wallet (WalletNumber)
import Wallet.Rollup.Types (AnnotatedTx)

_simulations :: Lens' State (Cursor Simulation)
_simulations = _Newtype <<< prop (SProxy :: SProxy "simulations")

_actionDrag :: Lens' State (Maybe Int)
_actionDrag = _Newtype <<< prop (SProxy :: SProxy "actionDrag")

_evaluationResult :: Lens' State (WebData (Either PlaygroundError EvaluationResult))
_evaluationResult = _Newtype <<< prop (SProxy :: SProxy "evaluationResult")

_successfulEvaluationResult :: Traversal' State EvaluationResult
_successfulEvaluationResult = _evaluationResult <<< _Success <<< _Right

_lastEvaluatedSimulation :: Lens' State (Maybe Simulation)
_lastEvaluatedSimulation = _Newtype <<< prop (SProxy :: SProxy "lastEvaluatedSimulation")

_transactionsOpen :: Lens' State Boolean
_transactionsOpen = _Newtype <<< prop (SProxy :: SProxy "transactionsOpen")

_blockchainVisualisationState :: Lens' State Chain.State
_blockchainVisualisationState = _Newtype <<< prop (SProxy :: SProxy "blockchainVisualisationState")

------------------------------------------------------------
_simulationId :: Lens' Simulation Int
_simulationId = _Newtype <<< prop (SProxy :: SProxy "simulationId")

_simulationActions :: Lens' Simulation (Array (ContractCall FormArgument))
_simulationActions = _Newtype <<< prop (SProxy :: SProxy "simulationActions")

_simulationWallets :: Lens' Simulation (Array SimulatorWallet)
_simulationWallets = _Newtype <<< prop (SProxy :: SProxy "simulationWallets")

_resultRollup :: Lens' EvaluationResult (Array (Array AnnotatedTx))
_resultRollup = _Newtype <<< prop (SProxy :: SProxy "resultRollup")

_walletKeys :: Lens' EvaluationResult (Array (JsonTuple PubKeyHash WalletNumber))
_walletKeys = _Newtype <<< prop (SProxy :: SProxy "walletKeys")
