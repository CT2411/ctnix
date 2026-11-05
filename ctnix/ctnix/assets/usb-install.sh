set -eu
[ "$(id -u)" -eq 0 ] || exec sudo sh "$0"

rm -rf /tmp/ctnix
git clone https://github.com/CT2411/ctnix /tmp/ctnix
exec sh /tmp/ctnix/assets/install.sh "$(dirname "$(readlink -f "$0")")"
