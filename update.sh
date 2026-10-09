#!/bin/sh
# Writes bucket/ssp.json for a release of sub-screen-player: the latest one, or the tag in $1.
# The checksums come from the release's SHA256SUMS.txt.
#
#   sh update.sh           # the latest release
#   sh update.sh v0.5.1    # a given one
set -eu
cd "$(dirname "$0")"
repo=nomunomu0504/sub-screen-player

tag=${1:-}
if [ -z "$tag" ]; then
	# The latest release page redirects to .../releases/tag/<version>.
	tag=$(curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/$repo/releases/latest")
	tag=${tag##*/}
fi
case "$tag" in
v[0-9]*) ;;
*) echo "cannot tell the latest version (got '$tag')" >&2; exit 1 ;;
esac

url="https://github.com/$repo/releases/download/$tag"
sums=$(curl -fsSL "$url/SHA256SUMS.txt")
sum() {
	s=$(printf '%s\n' "$sums" | awk -v f="ssp-$tag-$1.zip" '$2 == f || $2 == "*" f { print $1 }')
	[ ${#s} -eq 64 ] || { echo "no checksum for ssp-$tag-$1.zip" >&2; exit 1; }
	echo "$s"
}
x64=$(sum x86_64-pc-windows-msvc)
arm64=$(sum aarch64-pc-windows-msvc)

# checkver and autoupdate let Scoop's own tools follow new releases too.
cat > bucket/ssp.json <<EOF
{
    "version": "${tag#v}",
    "description": "Shows clocks, dashboards, web pages and videos on USB bar displays",
    "homepage": "https://subscreen.dev",
    "license": "MIT|Apache-2.0",
    "architecture": {
        "64bit": {
            "url": "$url/ssp-$tag-x86_64-pc-windows-msvc.zip",
            "hash": "$x64",
            "extract_dir": "ssp-$tag-x86_64-pc-windows-msvc"
        },
        "arm64": {
            "url": "$url/ssp-$tag-aarch64-pc-windows-msvc.zip",
            "hash": "$arm64",
            "extract_dir": "ssp-$tag-aarch64-pc-windows-msvc"
        }
    },
    "bin": "ssp.exe",
    "notes": [
        "To start the daemon now and whenever you sign in: ssp service install",
        "Before updating ssp, end the daemon (taskkill /im ssp.exe); afterwards run ssp service install again."
    ],
    "checkver": "github",
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://github.com/$repo/releases/download/v\$version/ssp-v\$version-x86_64-pc-windows-msvc.zip",
                "extract_dir": "ssp-v\$version-x86_64-pc-windows-msvc"
            },
            "arm64": {
                "url": "https://github.com/$repo/releases/download/v\$version/ssp-v\$version-aarch64-pc-windows-msvc.zip",
                "extract_dir": "ssp-v\$version-aarch64-pc-windows-msvc"
            }
        },
        "hash": {
            "url": "\$baseurl/SHA256SUMS.txt"
        }
    }
}
EOF
echo "bucket/ssp.json: $tag"
