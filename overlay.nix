final: prev: {
  brightness-bar = let watcher = final.callPackage ./derivation.nix { };
  in final.writeShellScriptBin "brightness-bar" ''
    ${watcher}/bin/brightness-watcher.py | ${final.xob}/bin/xob -c ${
      ./xob.config
    } -s default
  '';
}
