{pkgs}: {
  enable = true;
  bashrcExtra = ''
    eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

    cdx() { z "$1"; ls -l; }; alias cd="cdx"

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
          --query "Reservations[].Instances[].Tags[?Key == 'Name']" \
          | jq -r '.[] | .[] | .Value' | sort -u \
          | ${pkgs.fzf}/bin/fzf --ignore-case --height=10 --layout reverse
      )
      aws ssm start-session --target $(
        aws ec2 describe-instances --filter Name=tag:Name,Values=$NAME \
        | jq -r '.Reservations[0].Instances[0].InstanceId'
      );
    }
  '';
}
