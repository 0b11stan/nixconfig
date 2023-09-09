{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ropnop";
  version = "v1.0.3";

  src = fetchFromGitHub {
    owner = "ropnop";
    repo = "kerbrute";
    rev = "${version}";
    sha256 = "sha256-HC7iCu16iGS9/bEXfvRLG9cXns6E+jZvqbIaN9liFB4=";
  };

  vendorSha256 = "sha256-8/3NyKz0rLo3Js6iwzDUki6K/BrljLkl4K9tNgK59XA=";
}
