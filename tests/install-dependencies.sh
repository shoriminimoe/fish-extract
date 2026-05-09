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
	sevenzip_url="https://www.7-zip.org/a/7z2405-linux-x64.tar.xz"
	sevenzip_sha256="8a5bdf9360113764e9df19f433c15097f364924d624ff9c098848f6d0d35bf9f"
	wget -O "$tmpdir/7zip.tar.xz" "$sevenzip_url"
	echo "$sevenzip_sha256  $tmpdir/7zip.tar.xz" | sha256sum -c -
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
