# M5Stack Switch Controller Monitor

M5Stack に USB Host Shield を接続し、Nintendo Switch 用コントローラー (HORI PAD TURBO 等) の入力値をリアルタイムで LCD に表示するモニタリングツールです。

## 機能

- **USB Host 接続**: M5Stack USB モジュール (MAX3421E) を介してコントローラーを認識
- **入力可視化**:
    - **ボタン**: A, B, X, Y, L, R, ZL, ZR, +, -, Home, Capture, Stick Click の押下状態を表示
    - **アナログスティック**: 左・右スティックの現在値を数値とグラフィックで表示
    - **十字キー (DPAD)**: 押されている方向 (UP, RIGHT, DOWN-LEFT 等) をテキストとビジュアルで表示
- **デバッグ情報**: 生の HID レポートデータ (Hex Dump) を表示

## 必要ハードウェア

- **M5Stack Core** (Basic, Gray, Fire 等)
- **M5Stack USB Module** (MAX3421E 搭載の USB Host Shield)
- **Nintendo Switch 対応 USB コントローラー** (動作確認済み: HORI PAD TURBO)

## 開発環境 & 依存ライブラリ

ビルドには [Arduino CLI](https://arduino.github.io/arduino-cli/) を使用します。

### 依存ライブラリ (自動インストールされます)
- M5Stack
- USB Host Shield Library 2.0

## 使い方

プロジェクトのルートディレクトリで `build.ps1` PowerShell スクリプトを実行します。

### ビルドと書き込み (自動検出)
```powershell
.\build.ps1
```

### ビルドと書き込み (COMポート指定)
```powershell
.\build.ps1 -Port COM5
```

## ライセンス

[MIT License](LICENSE)

Copyright (c) 2026 Noriki Nakamura
