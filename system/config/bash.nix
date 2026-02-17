{pkgs}: {
  enable = true;

  bashrcExtra = ''
    eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

    cdx() { z "$1"; ls -l; }; alias cd="cdx"

    icat() {
      mkdir -p /tmp/sixel;
      ${pkgs.libsixel}/bin/img2sixel -o /tmp/sixel/$1.six -w 1000px $1;
      cat /tmp/sixel/$1.six;
    }

    aws-login() {
      export AWS_PROFILE=$(
        aws configure list-profiles \
        | ${pkgs.fzf}/bin/fzf --ignore-case --height=10 --layout reverse
      )
      echo "Logging to $AWS_PROFILE"
      aws sso login --profile "$AWS_PROFILE"
    }

    awssm() {
      NAME=$(
        aws ec2 describe-instances \
          --filters Name=instance-state-name,Values=running \
          --query "Reservations[].Instances[].Tags[?Key == 'Name']" \
          | jq -r '.[] | .[] | .Value' | sort -u \
          | ${pkgs.fzf}/bin/fzf --ignore-case --height=10 --layout reverse
      )
      aws ssm start-session --target $(
        aws ec2 describe-instances \
          --filters Name=instance-state-name,Values=running Name=tag:Name,Values=$NAME \
          | jq -r '.Reservations[0].Instances[0].InstanceId'
      );
    }

    kdrive() {
      pass -c deepjump/infomaniak
      mkdir -p ~/kdrive/
      sudo mount.davfs -o rw,uid=1000,gid=1000 https://1476083.connect.kdrive.infomaniak.com ~/kdrive/
    }

    backup() {
      kdrive

      cd ~/.local/share/password-store/ \
        && git bundle create passwords.git master \
        && mv passwords.git ~/kdrive/

      cd ~/notes/ \
        && git bundle create notes.git master \
        && mv notes.git ~/kdrive/
    }

    aws-secrets() {
      # List secret names, let user select one
      local SECRET_NAME=$(aws secretsmanager list-secrets \
        --query 'SecretList[].Name' --output text | tr '\t' '\n' | sort | fzf --height=15 --reverse --prompt="Select secret: ")

      [[ -z "$SECRET_NAME" ]] && return

      # Get the secret value
      local SECRET_STRING=$(aws secretsmanager get-secret-value --secret-id "$SECRET_NAME" --query 'SecretString' --output text)

      # Try to pretty-print JSON secrets, otherwise print as is
      if echo "$SECRET_STRING" | jq -e . >/dev/null 2>&1; then
        echo "$SECRET_STRING" | jq
      else
        echo "$SECRET_STRING"
      fi
    }

    file-fzf-hack() {
      if [ $# -lt 1 ]; then
        fd --type f | fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {}),esc:abort"
      else
        fd --type f "$1" | fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {}),esc:abort"
      fi
    }
    alias ffp='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+}),esc:abort"'
    alias fdp='fzf -m --preview="eza --icons=always --color=always {}" --bind "enter:execute(cd {} && clear),esc:abort"'
    alias vsf='file-fzf-hack'
  '';
}
