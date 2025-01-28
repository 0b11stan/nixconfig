{pkgs}: {
  enable = true;
  bashrcExtra = ''
    cdx() { cd "$1"; ls -l; }; alias cd="cdx"

    aws-login() {
      export AWS_PROFILE=$(aws configure list-profiles | ${pkgs.fzf}/bin/fzf)
      echo "Logging to $AWS_PROFILE"
      aws sso login --profile "$AWS_PROFILE"
    }

    awssm() {
      aws ssm start-session --target $(
        aws ec2 describe-instances --filter Name=tag:Name,Values=$1 \
        | jq -r '.Reservations[0].Instances[0].InstanceId'
      );
    }
  '';
}
