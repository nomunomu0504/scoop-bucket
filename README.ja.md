# sub-screen-player の Scoop bucket

[English](README.md)

[sub-screen-player](https://github.com/nomunomu0504/sub-screen-player)（`ssp`）は、USB のサブディスプレイに
時計・ダッシュボード・Web ページ・動画を表示するツールです。Windows では [Scoop](https://scoop.sh) で
インストールできます。

```powershell
scoop bucket add nomunomu0504 https://github.com/nomunomu0504/scoop-bucket
scoop install nomunomu0504/ssp
ssp service install      # デーモンを今すぐ起動し、サインインのたびに起動する
```

更新するときは、先にデーモンを終了してから（`taskkill /im ssp.exe`）、`scoop update ssp` を実行し、もう一度
`ssp service install` を実行してください。

マニフェストは、各[リリース](https://github.com/nomunomu0504/sub-screen-player/releases)に添付されたバイナリ
（x64 と ARM64）を、リリースの `SHA256SUMS.txt` で確かめてインストールします。マニフェストは
[`update.sh`](update.sh) が書き出し、ワークフローが 1 時間ごとに実行して、Windows の x64 と ARM64 で
インストールできたものだけをコミットします。問題は
[sub-screen-player の Issue](https://github.com/nomunomu0504/sub-screen-player/issues) に報告してください。
