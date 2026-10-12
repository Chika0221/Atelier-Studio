#!/usr/bin/env bash
# デーモン（Rust）と GUI（Flutter）を release ビルドして dist/ に集める（Linux 用）。
#
# 使い方:
#   scripts/build_all.sh         # dist/linux/atelier/ に並べるだけ
#   scripts/build_all.sh --deb   # さらに dist/atelier-studio_<version>_amd64.deb を作る
#
# Windows は packaging/windows/make_zip.ps1 を使う。
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT=$(pwd)

MAKE_DEB=0
for arg in "$@"; do
    case "$arg" in
        --deb) MAKE_DEB=1 ;;
        *) echo "unknown option: $arg" >&2; exit 1 ;;
    esac
done

# pubspec.yaml の version（"1.0.0+1" の + より前）
VERSION=$(sed -nE 's/^version:[[:space:]]*([^+[:space:]]+).*/\1/p' pubspec.yaml)

echo "==> daemon (cargo build --release)"
cargo build --release --manifest-path daemon/Cargo.toml -p atelier-daemon

echo "==> gui (flutter build linux --release)"
flutter build linux --release

DIST="$ROOT/dist"
STAGE="$DIST/linux/atelier"
rm -rf "$DIST"
mkdir -p "$STAGE"

# GUI は daemon_launcher.dart が「同じディレクトリのデーモン」を探すので同じ場所に並べる
cp -r build/linux/x64/release/bundle/. "$STAGE/"
cp daemon/target/release/atelier-daemon "$STAGE/"
echo "==> $STAGE"

if [[ $MAKE_DEB -eq 0 ]]; then
    exit 0
fi

echo "==> deb"
PKG="$DIST/deb-root"
mkdir -p "$PKG/DEBIAN" \
         "$PKG/usr/lib/atelier" \
         "$PKG/usr/lib/udev/rules.d" \
         "$PKG/usr/lib/systemd/user" \
         "$PKG/usr/bin"

sed "s/@VERSION@/$VERSION/" packaging/linux/deb/control > "$PKG/DEBIAN/control"
install -m 755 packaging/linux/deb/postinst "$PKG/DEBIAN/postinst"

cp -r "$STAGE/." "$PKG/usr/lib/atelier/"
install -m 644 packaging/linux/99-atelier.rules "$PKG/usr/lib/udev/rules.d/"
install -m 644 packaging/linux/atelier-daemon.service "$PKG/usr/lib/systemd/user/"
ln -sf /usr/lib/atelier/atelier_studio "$PKG/usr/bin/atelier-studio"

DEB="$DIST/atelier-studio_${VERSION}_amd64.deb"
dpkg-deb --root-owner-group --build "$PKG" "$DEB"
echo "==> $DEB"
