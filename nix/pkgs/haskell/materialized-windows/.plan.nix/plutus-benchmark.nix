{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = {};
    package = {
      specVersion = "2.2";
      identifier = { name = "plutus-benchmark"; version = "0.1.0.0"; };
      license = "Apache-2.0";
      copyright = "";
      maintainer = "radu.ometita@iohk.io";
      author = "Radu Ometita";
      homepage = "https://github.com/iohk/plutus#readme";
      url = "";
      synopsis = "";
      description = "Please see the README on GitHub at <https://github.com/input-output-hk/plutus#readme>";
      buildType = "Simple";
      isLocal = true;
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" "NOTICE" ];
      dataDir = ".";
      dataFiles = [ "templates/*.tpl" "validation/data/*.flat" ];
      extraSrcFiles = [];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      exes = {
        "nofib-exe" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            (hsPkgs."ansi-wl-pprint" or (errorHandler.buildDepError "ansi-wl-pprint"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."flat" or (errorHandler.buildDepError "flat"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            ];
          buildable = true;
          modules = [
            "Plutus/Benchmark/Clausify"
            "Plutus/Benchmark/Queens"
            "Plutus/Benchmark/Knights"
            "Plutus/Benchmark/Knights/ChessSetList"
            "Plutus/Benchmark/Knights/KnightHeuristic"
            "Plutus/Benchmark/Knights/Queue"
            "Plutus/Benchmark/Knights/Sort"
            "Plutus/Benchmark/Knights/Utils"
            "Plutus/Benchmark/LastPiece"
            "Plutus/Benchmark/Prime"
            ];
          hsSourceDirs = [ "nofib/exe" "nofib/src" ];
          mainPath = [ "Main.hs" ];
          };
        "list-sort-exe" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."monoidal-containers" or (errorHandler.buildDepError "monoidal-containers"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            ];
          buildable = true;
          modules = [ "GhcSort" "InsertionSort" "MergeSort" "QuickSort" ];
          hsSourceDirs = [ "list-sort/exe" "list-sort/src" ];
          mainPath = [ "Main.hs" ];
          };
        };
      tests = {
        "plutus-benchmark-nofib-tests" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
            (hsPkgs."tasty-quickcheck" or (errorHandler.buildDepError "tasty-quickcheck"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            ];
          buildable = true;
          modules = [
            "Paths_plutus_benchmark"
            "Plutus/Benchmark/Clausify"
            "Plutus/Benchmark/Queens"
            "Plutus/Benchmark/Knights"
            "Plutus/Benchmark/Knights/ChessSetList"
            "Plutus/Benchmark/Knights/KnightHeuristic"
            "Plutus/Benchmark/Knights/Queue"
            "Plutus/Benchmark/Knights/Sort"
            "Plutus/Benchmark/Knights/Utils"
            "Plutus/Benchmark/LastPiece"
            "Plutus/Benchmark/Prime"
            ];
          hsSourceDirs = [ "nofib/test" "nofib/src" ];
          mainPath = [ "Spec.hs" ];
          };
        "plutus-benchmark-list-sort-tests" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-quickcheck" or (errorHandler.buildDepError "tasty-quickcheck"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            ];
          buildable = true;
          modules = [ "GhcSort" "InsertionSort" "MergeSort" "QuickSort" ];
          hsSourceDirs = [ "list-sort/test" "list-sort/src" ];
          mainPath = [ "Spec.hs" ];
          };
        };
      benchmarks = {
        "nofib" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."criterion" or (errorHandler.buildDepError "criterion"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            ];
          buildable = true;
          modules = [
            "Common"
            "Paths_plutus_benchmark"
            "Plutus/Benchmark/Clausify"
            "Plutus/Benchmark/Queens"
            "Plutus/Benchmark/Knights"
            "Plutus/Benchmark/Knights/ChessSetList"
            "Plutus/Benchmark/Knights/KnightHeuristic"
            "Plutus/Benchmark/Knights/Queue"
            "Plutus/Benchmark/Knights/Sort"
            "Plutus/Benchmark/Knights/Utils"
            "Plutus/Benchmark/LastPiece"
            "Plutus/Benchmark/Prime"
            ];
          hsSourceDirs = [ "nofib/bench" "nofib/src" ];
          };
        "nofib-hs" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."criterion" or (errorHandler.buildDepError "criterion"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            ];
          buildable = true;
          modules = [
            "Common"
            "Paths_plutus_benchmark"
            "Plutus/Benchmark/Clausify"
            "Plutus/Benchmark/Queens"
            "Plutus/Benchmark/Knights"
            "Plutus/Benchmark/Knights/ChessSetList"
            "Plutus/Benchmark/Knights/KnightHeuristic"
            "Plutus/Benchmark/Knights/Queue"
            "Plutus/Benchmark/Knights/Sort"
            "Plutus/Benchmark/Knights/Utils"
            "Plutus/Benchmark/LastPiece"
            "Plutus/Benchmark/Prime"
            ];
          hsSourceDirs = [ "nofib/bench" "nofib/src" ];
          };
        "list-sort" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."criterion" or (errorHandler.buildDepError "criterion"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            ];
          buildable = true;
          modules = [
            "Paths_plutus_benchmark"
            "GhcSort"
            "InsertionSort"
            "MergeSort"
            "QuickSort"
            ];
          hsSourceDirs = [ "list-sort/bench" "list-sort/src" ];
          };
        "validation" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."criterion" or (errorHandler.buildDepError "criterion"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."flat" or (errorHandler.buildDepError "flat"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            ];
          buildable = true;
          modules = [ "NaturalSort" "Paths_plutus_benchmark" ];
          hsSourceDirs = [ "validation" ];
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ../plutus-benchmark; }