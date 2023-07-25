#!/bin/bash
set -e
export PATH="/usr/lib/ccache/bin:$PATH"
sudo chmod -R a+rw $HOME/.cache/ccache
cd $HOME
git clone -b master https://github.com/CachyOS/linux-cachyos
cd linux-cachyos/$PKG
echo "Compiling kernel..."
KBUILD_BUILD_TIMESTAMP='' \
env _processor_opt="sandybridge" \
_disable_debug=y \
_NUMAdisable=y \
_nr_cpus=4 \
_use_auto_optimization='' \
_localmodcfg=y \
_cc_harder=y \
makepkg -s --noconfirm
echo "Logining in to GitHub..."
printenv GITHUB_KEY | gh auth login --with-token
minor=$(grep _minor PKGBUILD | head -1 | cut -c 8-)
major=$(grep _major PKGBUILD | head -1 | cut -c 8-)
pkgrel=$(grep pkgrel PKGBUILD | head -1 | cut -c 8-)
scheduler=$(printenv PKG | cut -c 15-)
version="$scheduler-v$major.$minor-$pkgrel"
repo=$(printenv REPO)
echo "Checking for same release..."
set +e
gh release view "$version" --repo "$repo"
tag_exists=$?
set -e
if test $tag_exists -eq 0; then
    echo "Tag already exists!"
    echo "Removing previous release..."
    gh release delete "$version" -y --cleanup-tag --repo "$repo"
fi
echo "Releasing $version binaries into $repo"
gh release create "$version" ./*.pkg.tar.zst --repo "$repo"
echo "Released!"
echo "Loging out from Github..."
gh auth logout -h github.com
