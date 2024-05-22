#!/usr/bin/env bash
set -euo pipefail

install_linux() {
	sudo apt-get update
	sudo apt-get install -y \
		bzip2 \
		gzip \
		lrzip \
		lz4 \
		lzip \
		lzma \
		lzop \
		ncompress \
		pigz \
		tar \
		wget \
		xz-utils \
		zip \
		zstd

	tmpdir=$(mktemp -d)
	wget -O "$tmpdir/7zip.tar.xz" https://www.7-zip.org/a/7z2405-linux-x64.tar.xz
	tar xf "$tmpdir/7zip.tar.xz" -C "$tmpdir"
	sudo mv -t /usr/local/bin/ "$tmpdir/7zz"
}

install_mac() {
	brew update
	brew install \
		bzip2 \
		gzip \
		lrzip \
		lz4 \
		lzip \
		lzop \
		pigz \
		gnu-tar \
		xz \
		zip \
		sevenzip \
		zstd
	port install \
		lzma \
		ncompress
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	install_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
	install_mac
else
	echo "Unsupported OS"
	exit 1
fi
