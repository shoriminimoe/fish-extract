function _extract_help
  echo "usage: extract ARCHIVE"
end


function extract
  if test (count $argv) -lt 1
    _extract_help
    return 1
  end

  set file $argv[1]

  switch $file
    case '*.tar.gz' '*.tgz'
      tar xvzf "$file"

    case '*.tar.bz2' '*.tbz' '*.tbz2'
      tar xvjf "$file"

    case '*.tar'
      tar xvf "$file"

    case '*.gz'
      gunzip -k "$file"

    case '*.bz2'
      bunzip2 "$file"

    case '*.zip'
      unzip "$file"

    case '*'
      echo "extract: cannot extract '$file': no extractor implemented for file type"
      return 1
  end

  if test $status -ne 0
    echo "Failed to extract '$file'"
  end
end


function x
  extract $argv
end

