{ flake-utils, ... } @ inputs:
{
  # Small helper apps for managing herdr/endpoints.json.
  # `nix run .#herdr-endpoint-id` prints a random 128-bit hex id
  # (an undashed UUID) to use as the "id" of a new machine entry.
  apps = flake-utils.lib.eachSystemMap
    [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ]
    (system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        bin = pkgs.writeShellScriptBin "herdr-endpoint-id" ''
          ${pkgs.openssl}/bin/openssl rand -hex 16
        '';
        app = flake-utils.lib.mkApp { drv = bin; };
      in
      {
        default = app;
        herdr-endpoint-id = app;
      });
}
