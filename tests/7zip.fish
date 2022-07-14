source functions/extract.fish

touch bwah
set file bwah.7z
7zz a $file bwah

rm -f bwah
@echo === extract $file ===
@test "archive exists" -f $file
@test "extract $file" (extract $file >/dev/null) $status -eq 0
@test "archive remains" -f $file
@test "bwah is present" -f bwah
rm -f $file
rm -f bwah
