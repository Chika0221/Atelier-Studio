#!/usr/bin/env bash
# box_ui を更新したあとに依存を取り直す。
set -euo pipefail
cd "$(dirname "$0")/.."

flutter clean
flutter pub get
