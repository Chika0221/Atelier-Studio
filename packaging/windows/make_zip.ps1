# デーモンと GUI をビルドして 1つの zip にまとめる（Windows 用）。
#
# 使い方（リポジトリのどこからでも）:
#   powershell -ExecutionPolicy Bypass -File packaging\windows\make_zip.ps1
#
# 出力: dist\windows\atelier-studio-<version>.zip
#   atelier\
#     atelier-daemon.exe      … 常駐デーモン（スタートアップ登録はデーモン自身が行う）
#     atelier_studio.exe      … 設定GUI（Flutter の Release 一式）
#     data\, *.dll

$ErrorActionPreference = 'Stop'

$Root = Resolve-Path (Join-Path $PSScriptRoot '..\..')
Set-Location $Root

# pubspec.yaml の version（"1.0.0+1" の + より前）を使う
$Version = (Select-String -Path 'pubspec.yaml' -Pattern '^version:\s*([^+\s]+)').Matches[0].Groups[1].Value

Write-Host "==> daemon (cargo build --release)"
cargo build --release --manifest-path daemon\Cargo.toml -p atelier-daemon
if ($LASTEXITCODE -ne 0) { throw 'cargo build failed' }

Write-Host "==> gui (flutter build windows --release)"
flutter build windows --release
if ($LASTEXITCODE -ne 0) { throw 'flutter build failed' }

$Dist  = Join-Path $Root 'dist\windows'
$Stage = Join-Path $Dist 'atelier'
if (Test-Path $Dist) { Remove-Item $Dist -Recurse -Force }
New-Item -ItemType Directory -Path $Stage | Out-Null

# GUI は daemon_launcher.dart が「同じディレクトリのデーモン」を探すので同じ場所に並べる
Copy-Item 'build\windows\x64\runner\Release\*' $Stage -Recurse
Copy-Item 'daemon\target\release\atelier-daemon.exe' $Stage

$Zip = Join-Path $Dist "atelier-studio-$Version.zip"
Compress-Archive -Path $Stage -DestinationPath $Zip
Write-Host "==> $Zip"
