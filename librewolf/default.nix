{...}: {
  homeModules.librewolf = {...}: {
    programs.librewolf = {
      enable = true;
      profiles.carl = (import ./profiles/carl.nix) // {isDefault = true;};
      profiles.acs = import ./profiles/acs.nix;
    };
  };

  homeModules.librewolf-acs = {...}: {
    programs.librewolf = {
      enable = true;
      profiles.carl = import ./profiles/carl.nix;
      profiles.acs = (import ./profiles/acs.nix) // {isDefault = true;};
    };
  };
}
