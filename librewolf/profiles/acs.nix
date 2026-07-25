(import ./common.nix)
// {
  id = 1;
  name = "ACS";
  bookmarks = {
    force = true;
    settings = [
      (import ../bookmarks/nix-sites.nix)
      (import ../bookmarks/acs.nix)
    ];
  };
}
