{ version
, system ? builtins.currentSystem
}:

let
  flake = builtins.getFlake (toString ./.);
  pkgs = flake.legacyPackages.${system};
  inherit (pkgs.voomio-bulk-purchase.project.voomio-bulk-purchase) src;
  inherit (pkgs.voomio-bulk-purchase) assets;
in
pkgs.runCommand "voomio-bulk-purchase-${version}.tar.gz" { } ''
  DIR=voomio-bulk-purchase-${version}

  mkdir -p $DIR

  # copy the source
  cp --recursive --no-preserve=all ${src}/. $DIR/.

  # copy the assets (plutus script file, address files)
  cp --recursive --no-preserve=all ${assets}/. $DIR/.

  # create the tarball
  tar -zcf $out $DIR
''
