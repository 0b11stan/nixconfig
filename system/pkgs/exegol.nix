{
  pkgs,
  fetchPypi,
}: let
  python = let
    packageOverrides = self: super: {
      docker = super.docker.overridePythonAttrs (old: rec {
        version = "6.1.3";
        src = super.fetchPypi {
          pname = "docker";
          inherit version;
          hash = "sha256-qm0XgwBFul7wFo1eqjTTe+6xE5SMQTr/4dWZH8EfmiA=";
        };
      });
      requests = super.requests.overridePythonAttrs (old: rec {
        version = "2.31.0";
        src = super.fetchPypi {
          pname = "requests";
          inherit version;
          hash = "sha256-lCxadY+Y15Dq7Ropy27vx/+w0c968Fw9J5Flbb1q0eE=";
        };
      });
      rich = super.rich.overridePythonAttrs (old: rec {
        version = "13.4.2";
        doCheck = false;
        src = super.fetchPypi {
          pname = "rich";
          inherit version;
          hash = "sha256-1lPWvM7eWEQwTGBdWqyALHz5Yh79cAtGx+wrUeqRSJg=";
        };
      });
    };
  in
    pkgs.python311.override {
      inherit packageOverrides;
      self = python;
    };
in
  pkgs.python311Packages.buildPythonPackage rec {
    pname = "Exegol";
    version = "4.2.5";
    format = "setuptools";

    propagatedBuildInputs = with python.pkgs; [
      pyyaml
      gitpython
      docker
      requests
      rich
      argcomplete
    ];

    doCheck = false;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-X/3Bu0LI/O7sSI5Y3ot497ArGfcRoBPbxkdT+mieapM=";
    };
  }
