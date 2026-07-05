{
  description = "Lean 4 playground dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        formatter = treefmtEval.config.build.wrapper;

        devShells.default = pkgs.mkShell {
          packages = [
            treefmtEval.config.build.wrapper
            pkgs.zsh
            # elan は Lean のツールチェーンマネージャ。lean-toolchain に書かれた
            # バージョンの lean / lake を自動で取得する(初回のみ ~/.elan へDL)。
            pkgs.elan
          ];

          shellHook = ''
            # nixpkgs の elan は自己アップデートできないため無効化する。
            export ELAN_TOOLCHAIN_AUTO_UPDATE=0

            echo "Lean playground dev shell"
            echo "  lean-toolchain: $(cat lean-toolchain 2>/dev/null || echo 'なし')"
            echo "  初回は 'lake build' 実行時に elan がツールチェーンを取得します。"
          '';
        };
      }
    );
}
