source functions/extract.fish

touch bwah
tar cf bwah.tar bwah
tar czf bwah.tgz bwah
tar czf bwah.tar.gz bwah
tar cjf bwah.tbz2 bwah
tar cjf bwah.tar.bz2 bwah
tar cJf bwah.txz bwah
tar cJf bwah.tar.xz bwah
tar --lzop -cf bwah.tar.lzo bwah
tar --lzip -cf bwah.tar.lz bwah
tar --lzma -cf bwah.tar.zma bwah
tar --lzma -cf bwah.tar.lzma bwah
tar --lzma -cf bwah.tlz bwah
tar --zstd -cf bwah.tar.zst bwah
tar --zstd -cf bwah.tzst bwah
tar --compress -cf bwah.tar.Z bwah
tar --compress -cf bwah.taz bwah
lz4 bwah.tar bwah.tar.lz4
lrztar bwah

set --local test_files \
  bwah.tar \
  bwah.tar.Z \
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
  bwah.tzst

for file in $test_files
  rm -f bwah
  @echo === extract $file ===
  @test "archive exists" -f $file
  @test "extract $file" (extract $file >/dev/null) $status -eq 0
  @test "archive remains" -f $file
  @test "bwah is present" -f bwah
  rm -f $file
end
