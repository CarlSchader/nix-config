{
  carl = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIN/sQiWl/z33QQMN70MenMKDj3enVgpEVoFVus+PaHWNAAAABHNzaDo= yubikey-carl"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMIssaCueh863XJ1p8wVWNScHOehySTPmrZPjyK9PDJAAAAABHNzaDo= carls-yubikey-2"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAID5SFmX6iIuILf/Xljssm1C8QgEv0jUQW2aoEh1h6WRHAAAABHNzaDo= yubikey3"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHuG0LK/0zJ0aShQ9o83SJX+q/N3Cm+QvIW+XVHDPrPLAAAABHNzaDo= yubikey4"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILEjIcDH2DSXG2YKqnevd5K2q+kHQSBRsTvhtOHX7uwWAAAABHNzaDo= carlschader@proton.me-27509234"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHYXxR9K5JF9bH2tbXsxfH+s4N3Aq9rH2eI9XpbDMhf0AAAABHNzaDo= carlschader@proton.me-27509235"
  ];

  nixbuild = [
    ''command="nix-daemon --stdio",no-port-forwarding,no-x11-forwarding,no-agent-forwarding ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAwHLXIlF+Q+1ibFCWyZ2LJcBuELgC9wJDSsr97NCSca carl@ml-pc''
  ];

  acs = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOkLIgD4V6YgIXHWPMW+UZrneAHJXyQlc2q86f84hr+ carl@acs-lenovo"
  ];

  connor = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE8N1WCZEQv43tuIvndSbtSPa3uYxFUfGh6LN0BFbnyt connorjones@MacBookPro" # connor
  ];

  jav = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICeGCbI6tGjiCnb07I6LYWIe2Ig+fW5OukpMsPjwyaQ8"
    "no-touch-required sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIL6B2JPmPprjUZuGiS71/XOOfrlJPH5oyfgtaSApQEvZAAAABHNzaDo="
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvZz4gz+5WGHH7zDI5hW740UKbXEQWNB6IakhyMECCI"
  ];
}
