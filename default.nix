{ system ? builtins.currentSystem
}:

(builtins.getFlake (toString ./.)).legacyPackages.${system}.voomio-bulk-purchase.project
