# Atelier Studio

モジュール拡張型自作キーボード **Atelier Board** のコンパニオンアプリです。Windows / Linux でキーマップ、モジュールの割り当て、アプリ別音量、コマンド実行、OLED 表示をまとめて設定することを目指しています。

設計は **Flutter の設定GUI + Rust の常駐デーモン** の2プロセス構成です。両方をこのリポジトリで管理する予定ですが、現在は GUI の土台と通信・配布の設計ファイルまでが用意されています。

## 現在の状態

2026-10-18 時点のソースに基づく状態です。「設計済み」は利用可能な機能を意味しません。

| 項目 | 状態 |
| --- | --- |
| GUI | テーマ、720 × 500 の初期・最小ウィンドウ、カスタムタイトルバー、サイドバーの土台を実装 |
| ホーム | `HELLO` と動作確認用ボタンの仮画面 |
| IPC | メッセージ仕様と JSON Lines のサンプルあり。通信処理は未実装 |
| Rust デーモン | 未実装。`daemon/` と Cargo workspace はまだ存在しない |
| キーリマップ・モジュール設定・音量・コマンド・OLED | 未実装 |
| 配布 | スクリプトと設定の雛形あり。完成した配布物はまだ作れない |
| テスト | `test/` は空。自動テストは未追加 |

現段階の GUI の起動に、キーボード実機やデーモンは不要です。

## 開発環境

- Linux または Windows の Flutter desktop 開発環境。
- Dart SDK 制約 **`^3.14.0-294.0.dev`** を満たす Flutter SDK。stable チャネルで動くとは限りません。
- ローカル UI パッケージ `box_ui`。

本書作成時のローカル SDK は Flutter `3.49.0-1.0.pre-307` / Dart `3.14.0-294.0.dev`（master）です。環境の記録であり、SDK の固定や両OSでの動作保証ではありません。

`box_ui` は現在、`pubspec.yaml` に次の絶対パスで指定されています。

```yaml
box_ui:
  path: /home/chika/dev/flu/packages/box_ui
```

別環境では `box_ui` のソースを用意し、`path` を配置先に変更してから依存を取得してください。Windows でも変更が必要です。Rust はデーモン実装時に必要ですが、現在の GUI 単体の起動には使いません。

## 起動

リポジトリのルートで実行します。

```sh
flutter doctor -v
flutter pub get
flutter devices
```

Linux:

```sh
flutter run -d linux
```

Windows（Windows 上で実行）:

```powershell
flutter run -d windows
```

カスタムタイトルバーと仮のホーム画面が表示される想定です。実機との通信や設定保存はまだ行いません。

## 解析・ビルド

Linux:

```sh
flutter analyze
flutter build linux --release
```

Windows の GUI は Windows 上でビルドします。

```powershell
flutter build windows --release
```

これらは実行手順であり、本書作成時の実行成功を示すものではありません。`flutter test` はテスト追加後に使用します。現在はテストがないため、成功する検証コマンドとしては扱えません。

Linux で `box_ui` 更新後に依存を取り直す補助スクリプトもあります。`flutter clean` と `flutter pub get` を実行します。

```sh
bash scripts/reload_boxui.sh
```

### デーモン同梱ビルド

`scripts/build_all.sh`（Linux / deb）と `packaging/windows/make_zip.ps1`（Windows / zip）は将来の同梱配布用です。現状は `daemon/Cargo.toml` がなく、最初の Cargo ビルドで失敗します。

udev ルールの VID/PID は仮値、deb の Maintainer は未設定、`scripts/sync_vial_json.sh` は TODO のみです。配布や実機利用の前に確定・実装が必要です。

## リポジトリ構成

```text
lib/                     Flutter GUI（現在は画面の土台）
assets/fonts/            Kosugi Maru / Black Ops One と各ライセンス
linux/・windows/         Flutter のプラットフォームランナー
protocol/                IPC 仕様とメッセージ例
packaging/               配布設定・スクリプトの雛形
scripts/                 開発・ビルド補助スクリプト
test/                    テスト配置先（現在は空）
docs/                    本リポジトリの仕様・構成設計
```

将来の `daemon/`、`lib/core/`、`lib/features/`、`assets/keyboard/` 等は[構成設計](docs/directory-structure.md)に記載されています。現在のファイル構成とは区別してください。

## 仕様・関連資料

- [Atelier Studio 仕様書](docs/specification.md): 責務、機能要件、通信、データ、受け入れ条件、未決事項。
- [ディレクトリ構成設計](docs/directory-structure.md): Flutter / Rust の予定配置と依存方向。
- [IPC メッセージ仕様](protocol/ipc.md): GUI ↔ デーモン間の通信契約の正。

全体の上位仕様は Obsidian 保管庫で管理されています。

```text
/home/chika/ドキュメント/obsidian/Atelier-Core/Idea/モジュール拡張型自作キーボード 仕様書.md
```

上位仕様は分割ファイルを参照する構成です。特に「7-8 コンパニオンアプリ・ユースケース」「5-6 通信プロトコル・ファームウェア」「9-11 開発フェーズ・非機能要件・未決事項」「12 確定事項ログ」が本リポジトリに関係します。保管庫はリポジトリに同梱されていないため、本アプリに必要な要件は本リポジトリの仕様書にも記載しています。
