{lib}:
lib.mkMerge [
  (import ./common.nix)
  {
    id = 1;
    name = "acs";
    bookmarks = {
      force = true;
      settings = [
        (import ../bookmarks/nix-sites.nix)
        (import ../bookmarks/ai.nix)
        (import ../bookmarks/proton.nix)
        (import ../bookmarks/acs.nix)
      ];
    };
  }
]
