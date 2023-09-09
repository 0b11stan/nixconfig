{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ropnop";
  version = "v0.3.0";

  src = fetchFromGitHub {
    owner = "ropnop";
    repo = "go-windapsearch";
    rev = "${version}";
    sha256 = "sha256-zPaHHesMNKWodlHhAlcJHUT+mfJiYRWEo0mQSY5TmSM=";
  };

  vendorSha256 = "sha256-E0jzaiTLrVgVD8XHqntG1wFG4cVwnC1lv0l3/7Fn/R4=";
}
