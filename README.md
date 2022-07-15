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

Manual install:
```sh
mkdir -p ~/.config/fish/functions
curl https://raw.githubusercontent.com/shoriminimoe/fish-extract/main/functions/extract.fish >~/.config/fish/functions/extract.fish
```

## Usage

```sh
extract FILE [FILE ...]
```

## Supported Formats

| Supported | Extension                    | Description                          |
| :-------: | :--------------------------- | :----------------------------------- |
|    ✅     | `7z`                         | 7zip file                            |
|    ✅     | `Z`                          | Z archive (LZW)                      |
|    ✅     | `bz2`, `bz`                  | Bzip2 file                           |
|    ✅     | `gz`                         | Gzip file                            |
|    ✅     | `lrz`                        | LRZ archive                          |
|    ✅     | `lz4`                        | LZ4 archive                          |
|    ✅     | `lzma`                       | LZMA archive                         |
|    ✅     | `tar.Z`, `taz`               | Tarball with LZW compression         |
|    ✅     | `tar.bz2`, `tbz2`            | Tarball with bzip2 compression       |
|    ✅     | `tar.bz`, `tbz`              | Tarball with bzip compression        |
|    ✅     | `tar.gz`, `tgz`              | Tarball with gzip compression        |
|    ✅     | `tar.lrz`                    | Tarball with lrzip compression       |
|    ✅     | `tar.lz4`                    | Tarball with lz4 compression         |
|    ✅     | `tar.lz`                     | Tarball with lzip compression        |
|    ✅     | `tar.lzo`                    | Tarball with lzop compression        |
|    ✅     | `tar.xz`, `txz`              | Tarball with lzma2 compression       |
|    ✅     | `tar.lzma`, `tar.zma`, `tlz` | Tarball with lzma compression        |
|    ✅     | `tar.zst`, `tzst`            | Tarball with zstd compression        |
|    ✅     | `tar`                        | Tarball                              |
|    ✅     | `xz`                         | LZMA2 archive                        |
|    ✅     | `zip`                        | Zip archive                          |
|    ✅     | `zst`                        | Zstandard file (zstd)                |
|    ✅     | `zz`                         | ZLIB file                            |
|    ❌     | `aar`                        | Android library file                 |
|    ❌     | `apk`                        | Android app file                     |
|    ❌     | `cab`                        | Microsoft cabinet archive            |
|    ❌     | `cpio`                       | Cpio archive                         |
|    ❌     | `deb`                        | Debian package                       |
|    ❌     | `ear`                        | Enterprise Application aRchive       |
|    ❌     | `ipa`                        | iOS app package                      |
|    ❌     | `ipsw`                       | iOS firmware file                    |
|    ❌     | `jar`                        | Java Archive                         |
|    ❌     | `rar`                        | WinRAR archive                       |
|    ❌     | `rpm`                        | RPM package                          |
|    ❌     | `sublime-package`            | Sublime Text package                 |
|    ❌     | `war`                        | Web Application archive (Java-based) |
|    ❌     | `xpi`                        | Mozilla XPI module file              |
