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
├── flake.nix               # devShell 定義(elan + treefmt)
├── lean-toolchain          # 使用する Lean のバージョン固定
├── lakefile.toml           # lake(ビルドツール)の設定
├── Main.lean               # 実行ファイルのエントリポイント
├── Playground.lean         # ライブラリのルートモジュール
├── Playground/
│   └── Basic.lean          # サンプルの定義・定理
├── NaturalNumberGame.lean  # NNG 解答ライブラリのルートモジュール
└── NaturalNumberGame/
    ├── NngShim.lean        # NNG 固有補題(one_eq_succ_zero 等)を Nat 上に用意するシム
    ├── Level1.lean         # Tutorial World の各レベルの解答
    ├── Level2.lean
    ├── ...
    └── Level7.lean
```

> [!NOTE]
> NNG4 はブラウザ上では独自型 `MyNat` と独自補題を使う。ここでは Mathlib の `Nat` 上に
> 同名補題を [NngShim.lean](./NaturalNumberGame/NngShim.lean) で用意して解答を再現している。
> また NNG の `rw` は書き換えるだけだが Lean 標準の `rw` は自動で `rfl` を試すため、
> 数値レベル(Level3/4/7 等)では自動 `rfl` をしない `rewrite` を使っている。

---

## Natural Number Game の解答

ブラウザ版 [Natural Number Game](https://adam.math.hhu.de/) の解答を [NaturalNumberGame/](./NaturalNumberGame) 配下に
レベルごとに保存する。NNG の `ℕ` 記法・補題名・tactic は Mathlib に由来するため、
このプロジェクトは Mathlib へ依存している(下記参照)。

各レベルのファイルは `import Mathlib` して `example ... := by ...` を書くだけ。
`lake build` で全レベルがコンパイル(証明チェック)される。

```shell
cd LeanPlayground
lake build NaturalNumberGame
```

---

## Mathlib

数学ライブラリ [Mathlib](https://github.com/leanprover-community/mathlib4) は
[lakefile.toml](./lakefile.toml) に依存として追加済み(NNG が使うため)。
バージョンは lean-toolchain (`v4.30.0`) に一致するタグ `v4.30.0` を pin している。

初回チェックアウト後は、ビルド済みキャッシュを取得してからビルドする(Mathlibのフルビルドは非常に重いため)。

```shell
lake exe cache get   # Mathlib のビルド済み olean をダウンロード
lake build
```

依存を更新する場合は `lake update` を実行する。

> [!WARNING]
> Mathlibはlean-toolchainのバージョンに強く依存する。更新時は [Mathlibが要求するLeanバージョン](https://github.com/leanprover-community/mathlib4/blob/master/lean-toolchain) に [lean-toolchain](./lean-toolchain) と `lakefile.toml` の `rev` を合わせること。
