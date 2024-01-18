{pkgs}:
pkgs.python311Packages.buildPythonPackage rec {
  pname = "Exegol";
  version = "4.3.1";
  format = "setuptools";

  propagatedBuildInputs = with pkgs.python311.pkgs; [
    pyyaml
    gitpython
    docker
    requests
    rich
    argcomplete
  ];

  doCheck = false;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-cMbMmkG52A104iHVwe+6k1Fazi7fISeU/doWJqw5Whw=";
  };
}
