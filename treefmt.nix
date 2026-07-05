{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  # mdformat 本体は thematic break を変換するため、`---` のまま出力する
  # mdformat-simple-breaks プラグインを使う。programs.mdformat は package
  # 上書きを尊重しないため settings.formatter で直接指定する。
  settings.formatter.mdformat = {
    command = "${pkgs.mdformat.withPlugins (ps: with ps; [ ps.mdformat-simple-breaks ])}/bin/mdformat";
    includes = [ "*.md" ];
  };
}
