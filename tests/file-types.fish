source functions/extract.fish

touch bwah

# tar
tar cf bwah.tar bwah
tar czf bwah.tgz bwah
cp bwah.tgz bwah.tar.gz
tar cjf bwah.tbz2 bwah
cp bwah.tbz2 bwah.tbz
tar cjf bwah.tar.bz2 bwah
cp bwah.tar.bz2 bwah.tar.bz
tar cJf bwah.txz bwah
cp bwah.txz bwah.tar.xz
tar --lzop -cf bwah.tar.lzo bwah
tar --lzip -cf bwah.tar.lz bwah
tar --lzma -cf bwah.tar.zma bwah
cp bwah.tar.zma bwah.tar.lzma
cp bwah.tar.zma bwah.tlz
tar --zstd -cf bwah.tar.zst bwah
cp bwah.tar.zst bwah.tzst
tar --compress -cf bwah.tar.Z bwah
cp bwah.tar.Z bwah.taz
lz4 --quiet bwah.tar bwah.tar.lz4
lrzip --very-quiet bwah.tar

# 7z
7zz a bwah.7z bwah >/dev/null

# Z
compress -c bwah >bwah.Z

# bzip2
bzip2 --keep bwah
cp bwah.bz2 bwah.bz

# gzip
gzip --keep bwah

# jar
zip --quiet bwah.jar bwah

# lrzip
lrzip --very-quiet bwah

# lz4
lz4 --quiet bwah bwah.lz4

# lzma
lzma --quiet --keep bwah

# lzma2
xz --quiet --keep bwah

# xpi
zip --quiet bwah.xpi bwah

# zip
zip --quiet bwah.zip bwah

# zstd
zstd --force bwah 2>/dev/null

# zz
pigz --zlib --keep bwah

set --local test_files \
  bwah.7z \
  bwah.Z \
  bwah.bz \
  bwah.bz2 \
  bwah.gz \
  bwah.jar \
  bwah.lrz \
  bwah.lz4 \
  bwah.lzma \
  bwah.tar \
  bwah.tar.Z \
  bwah.tar.bz \
  bwah.tar.bz2 \
  bwah.tar.gz \
  bwah.tar.lrz \
  bwah.tar.lz \
  bwah.tar.lz4 \
  bwah.tar.lzma \
  bwah.tar.lzo \
  bwah.tar.xz \
  bwah.tar.zma \
  bwah.tar.zst \
  bwah.taz \
  bwah.tbz \
  bwah.tbz2 \
  bwah.tgz \
  bwah.tlz \
  bwah.txz \
  bwah.tzst \
  bwah.xpi \
  bwah.xz \
  bwah.zip \
  bwah.zz \
  bwah.zst

for file in $test_files
  rm -f bwah
  @echo === extract $file ===
  @test "archive exists" -f $file
  @test "extract $file" (extract $file >/dev/null) $status -eq 0
  @test "archive remains" -f $file
  @test "bwah is present" -f bwah
  rm -f $file
end

rm -f bwah
