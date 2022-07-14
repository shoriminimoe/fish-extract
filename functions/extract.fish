function _extract_help
  echo "usage: extract FILE [FILE ...]"
end


function extract -d "Extract archives"
  if test (count $argv) -lt 1
    _extract_help
    return 1
  end

  set failed false

  for file in $argv
    breakpoint
    switch $file
      case '*.7z'
        7zz x "$file"

      case '*.tar'
        tar xvf "$file"

      case '*.tar.gz' '*.tgz'
        tar xvzf "$file"

      case '*.tar.bz2' '*.tbz' '*.tbz2'
        tar xvjf "$file"

      case '*.tar.xz' '*.txz'
        tar xvJf "$file"

      case '*.tar.Z' '*.taz'
        tar xvZf "$file"

      case '*.tar.zst' '*.tzst'
        tar --zstd -xvf "$file"

      case '*.tar.lzma' '*.tar.zma' '*.tlz'
        tar --lzma -xvf "$file"

      case '*.lrz'
        lrzunzip "$file"

      case '*.tar.lrz'
        lrzuntar "$file"

      case '*.tar.lz'
        tar --lzip -xvf "$file"

      case '*.tar.lz4'
        unlz4 --to-stdout "$file" | tar xv

      case '*.tar.lzo'
        tar --lzop -xvf "$file"

      case '*.gz'
        gunzip --keep "$file"

      case '*.bz2'
        bunzip2 --keep "$file"

      case '*.xz'
        unxz --keep "$file"

      case '*.lzma'
        unlzma --keep "$file"

      case '*.zip'
        unzip "$file"

      case '*.Z'
        uncompress "$file"

      case '*'
        echo >&2 "extract: failed to extract '$file': no extractor implemented for file type"
        set failed true
    end

    if test $status -ne 0
      echo >&2 "Failed to extract '$file'"
      set failed true
    end
  end

  if $failed
    return 1
  end
end


function x
  extract $argv
end

