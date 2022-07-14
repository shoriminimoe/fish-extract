function _extract_help
  echo "usage: extract FILE [FILE ...]"
end


function extract -d "Extract archives"
  if test (count $argv) -lt 1
    _extract_help
    return 1
  end

  for file in $argv
    switch $file
      case '*.tar'
        tar xvf "$file"

      case '*.tar.gz' '*.tgz'
        tar xvzf "$file"

      case '*.tar.bz2' '*.tbz' '*.tbz2'
        tar xvjf "$file"

      case '*.tar.xz' '*.txz'
        tar xvJf "$file"

      case '*.tar.zma' '*.tlz'
        tar --lzma xvf "$file"

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

      case '*'
        echo "extract: failed to extract '$file': no extractor implemented for file type"
    end
  end

  if test $status -ne 0
    echo "Failed to extract '$file'"
  end
end


function x
  extract $argv
end

