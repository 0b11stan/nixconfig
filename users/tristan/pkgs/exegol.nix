{
  lib,
  stdenv,
  buildPythonPackage,
  fetchPypi,
}:
buildPythonPackage rec {
  version = "4.1.1";
  pname = "Exegol";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-FsXdcZOKzwmhPxnWPoyQ3hokIsOCDIx2AO/1YK6ostA=";
  };
}
