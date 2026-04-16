{ ... }:
{
  nixosModules.download-buffer =
    { ... }:
    let
      bufferSize = 1024 * 1024 * 128; # 128MB
    in
    {
      nix.settings = {
        # Increase the download buffer to 128MB (default is 6MB)
        download-buffer-size = bufferSize;

        # Increase simultaneous connections (default is 25)
        http-connections = 50;

        # Allow more parallel downloads (default is 16)
        max-substitution-jobs = 32;
      };
    };
}
