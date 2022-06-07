DIR="$( cd "$( dirname "$0" )" && pwd )"

docker run --rm \
  -v "$DIR/:/root/.aws" \
  -v $PWD:/project \
  amazon/aws-cli \
  "$@"