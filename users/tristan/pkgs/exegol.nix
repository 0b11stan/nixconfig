# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/python-modules/rich/default.nix
with import <nixpkgs> {};
with python310.pkgs;
  (
    let
      argcomplete = buildPythonPackage rec {
        pname = "argcomplete";
        version = "3.0.8";
        format = "setuptools";
        disabled = pythonOlder "3.7";
        propagatedBuildInputs = [pexpect];
        doCheck = false;
        pythonImportsCheck = ["argcomplete"];
        src = fetchPypi {
          inherit pname version;
          hash = "sha256-ucqWRI4U+kWddFCkq1oiu/nO5Lp63d8D5lw5i12u6ig=";
        };
        postPatch = ''
          substituteInPlace setup.py \
            --replace '"coverage",' "" \
            --replace " + lint_require" ""
        '';
      };

      docker = buildPythonPackage rec {
        pname = "docker";
        version = "6.1.2";
        format = "pyproject";
        disabled = pythonOlder "3.7";
        src = fetchPypi {
          inherit pname version;
          hash = "sha256-3MCIrcLsTnz8WU4nXYvSyXOMVsgI3pdHaTnvZ9ta+MI=";
        };
        nativeBuildInputs = [setuptools-scm];
        propagatedBuildInputs = [packaging requests urllib3 websocket-client];
        passthru.optional-dependencies.ssh = [paramiko];
        nativeCheckInputs =
          [
            pytestCheckHook
          ]
          ++ lib.flatten (builtins.attrValues passthru.optional-dependencies);
        pytestFlagsArray = ["tests/unit"];
        disabledTests = lib.optionals stdenv.isDarwin [
          "api_test"
          "stream_response"
          "socket_file"
        ];
        dontUseSetuptoolsCheck = true;
        pythonImportsCheck = ["docker"];
      };
      exegol = buildPythonPackage rec {
        pname = "Exegol";
        version = "4.2.3";

        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-LT9uDsYRQea+N6kYvWa29w7IdVLSf345btKWiBTN2To=";
        };

        propagatedBuildInputs = [
          setuptools
          GitPython
          rich
          argcomplete
          docker
        ];

        doCheck = false;
      };
    in
      python310.withPackages (ps: with ps; [exegol])
  )
  .env
