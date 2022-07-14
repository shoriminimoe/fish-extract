# fish-extract

An archive extraction plugin for
[fish-shell](https://github.com/fish-shell/fish-shell). Inspired by the
[oh-my-zsh extract plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract).


## Installation

Install using [fisher](https://github.com/jorgebucaran/fisher):

```sh
fisher install shoriminimoe/fish-extract
```

Install using [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish):

```sh
omf install shoriminimoe/fish-extract
```


## Usage

```sh
extract FILE [FILE ...]
```

## Supported archive formats

| Supported | Extension         | Description                          |
|:----------|:------------------|:-------------------------------------|
|           | `7z`              | 7zip file                            |
|           | `Z`               | Z archive (LZW)                      |
|           | `aar`             | Android library file                 |
|           | `apk`             | Android app file                     |
|           | `bz2`             | Bzip2 file                           |
|           | `cab`             | Microsoft cabinet archive            |
|           | `cpio`            | Cpio archive                         |
|           | `deb`             | Debian package                       |
|           | `ear`             | Enterprise Application aRchive       |
|           | `gz`              | Gzip file                            |
|           | `ipa`             | iOS app package                      |
|           | `ipsw`            | iOS firmware file                    |
|           | `jar`             | Java Archive                         |
|           | `lrz`             | LRZ archive                          |
|           | `lz4`             | LZ4 archive                          |
|           | `lzma`            | LZMA archive                         |
|           | `rar`             | WinRAR archive                       |
|           | `rpm`             | RPM package                          |
|           | `sublime-package` | Sublime Text package                 |
|           | `tar.bz2`, `tbz2` | Tarball with bzip2 compression       |
|           | `tar.gz`, `tgz`   | Tarball with gzip compression        |
|           | `tar.lrz`         | Tarball with lrzip compression       |
|           | `tar.lz4`         | Tarball with lz4 compression         |
|           | `tar.lz`          | Tarball with lzip compression        |
|           | `tar.xz`, `txz`   | Tarball with lzma2 compression       |
|           | `tar.zma`, `tlz`  | Tarball with lzma compression        |
|           | `tar.zst`, `tzst` | Tarball with zstd compression        |
|           | `tar`             | Tarball                              |
|           | `tbz`             | Tarball with bzip compression        |
|           | `tzst`            | Tarball with zstd compression        |
|           | `war`             | Web Application archive (Java-based) |
|           | `xpi`             | Mozilla XPI module file              |
|           | `xz`              | LZMA2 archive                        |
|           | `zip`             | Zip archive                          |
|           | `zst`             | Zstandard file (zstd)                |
