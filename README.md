# leanPlayground

[Lean 4](https://lean-lang.org/) を学ぶためのプレイグラウンド。定理証明とプログラミングの両方を試す。

## INDEX

- [ABOUT](#about)
- [ENVIRONMENT](#environment)
- [HOW TO USE](#how-to-use)

---

## ABOUT

[このツイート](https://x.com/TheoremForces/status/2058504069040193579)をきっかけにLeanに興味をもったので作成した学習用リポジトリ。
[`atcoder/`](https://github.com/RyosukeDTomita) の開発環境構成を参考に、nix flakeで環境を再現できるようにしている。

ツールチェーン(`lean` / `lake`)のバージョン管理はLean公式の[elan](https://github.com/leanprover/elan)に任せ、
nixはelan本体とフォーマッタだけを提供する。実際のLeanバージョンは[lean-toolchain](./lean-toolchain)で固定する。

---

## ENVIRONMENT

```shell
nix develop
```

direnvを使っている場合は `direnv allow` で自動的にdevShellに入る。

初回の `lake build` 実行時に、elanが [lean-toolchain](./lean-toolchain) に書かれたバージョン
(現在 `leanprover/lean4:v4.30.0`)を `~/.elan` へ自動ダウンロードする。

### (VS Code User)

- Extensionの `leanprover.lean4` をインストールする([extensions.json](./.vscode/extensions.json) に推奨として記載済み)。
- `nix develop` / direnvでelanがPATHに入っていれば、拡張機能がツールチェーンを自動認識する。
- 設定は [settings.json](./.vscode/settings.json) に記載している。

### (Zed User)

- Zedの公式なLeanサポートは限定的なため、現状はVS Codeを主に想定している。
- タブ幅等の最小設定は [settings.json](./.zed/settings.json) に置いている。

### (Dev Container User)

- [.devcontainer](./.devcontainer) にDev Container設定を置いている。`atcoder/` と同じくnixをコンテナ内に導入する構成。

---

## HOW TO USE

### プロジェクトのビルドと実行

```shell
# ライブラリと実行ファイルをビルドする
lake build

# 実行ファイル(playground)を実行する
lake exe playground
```

### 1ファイルを単体で実行する

```shell
# lake プロジェクトを介さず単一ファイルを実行する
lean --run Main.lean
```

### REPL的に式を評価する

`#eval` / `#check` をファイルに書いてエディタで結果を確認するのがLeanの基本スタイル。

```lean
#eval 1 + 1        -- 2
#check Nat.add     -- Nat → Nat → Nat
```

### Formatter

```shell
# Markdown を整形する(treefmt + mdformat)
nix fmt
```

> [!NOTE]
> Leanには広く使われる標準フォーマッタが無いため、`nix fmt` はMarkdownのみを対象にしている。

---

## ディレクトリ構成

```text
leanPlayground/
├── flake.nix          # devShell 定義(elan + treefmt)
├── lean-toolchain     # 使用する Lean のバージョン固定
├── lakefile.toml      # lake(ビルドツール)の設定
├── Main.lean          # 実行ファイルのエントリポイント
├── Playground.lean    # ライブラリのルートモジュール
└── Playground/
    └── Basic.lean     # サンプルの定義・定理
```

---

## Mathlibを使いたくなったら

数学ライブラリ [Mathlib](https://github.com/leanprover-community/mathlib4) を使う場合は
[lakefile.toml](./lakefile.toml) に依存を追加する。

```toml
[[require]]
name = "mathlib"
scope = "leanprover-community"
```

その後、ビルド済みキャッシュを取得してからビルドする(Mathlibのフルビルドは非常に重いため)。

```shell
lake update
lake exe cache get
lake build
```

> [!WARNING]
> Mathlibはlean-toolchainのバージョンに強く依存する。追加時は [Mathlibが要求するLeanバージョン](https://github.com/leanprover-community/mathlib4/blob/master/lean-toolchain) に [lean-toolchain](./lean-toolchain) を合わせること。
