(import ./common.nix)
// {
  id = 1;
  name = "acs";
  bookmarks = {
    force = true;
    settings = [
      (import ../bookmarks/acs.nix)
      (import ../bookmarks/nix-sites.nix)
      (import ../bookmarks/ai.nix)
      (import ../bookmarks/proton.nix)
    ];
  };
}
