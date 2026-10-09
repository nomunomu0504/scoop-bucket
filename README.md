# Scoop bucket for sub-screen-player

[日本語](README.ja.md)

[sub-screen-player](https://github.com/nomunomu0504/sub-screen-player) (`ssp`) shows clocks,
dashboards, web pages and videos on USB bar displays. Install it on Windows with
[Scoop](https://scoop.sh):

```powershell
scoop bucket add nomunomu0504 https://github.com/nomunomu0504/scoop-bucket
scoop install nomunomu0504/ssp
ssp service install      # start the daemon now and whenever you sign in
```

To update, end the daemon first (`taskkill /im ssp.exe`), then run `scoop update ssp` and
`ssp service install` again.

The manifest installs the binaries attached to each
[release](https://github.com/nomunomu0504/sub-screen-player/releases) (x64 and ARM64), checked
against the release's `SHA256SUMS.txt`. [`update.sh`](update.sh) writes it, and a workflow runs
it every hour and commits the result once it installs on Windows x64 and ARM64. Report problems
in the [sub-screen-player issues](https://github.com/nomunomu0504/sub-screen-player/issues).
