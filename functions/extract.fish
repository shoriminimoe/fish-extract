function _extract_help
    echo "usage: extract FILE [FILE ...]"
end


function extract -d "Extract archives"
    argparse --name=extract h/help -- $argv
    or return 1

    if set -q _flag_help
        _extract_help
        return 0
    end

    if test (count $argv) -lt 1
        _extract_help
        return 1
    end

    set --local tar tar
    if command -q gtar
        # use GNU tar if available. This is what gnu-tar is installed as on
        # macOS.
        set tar gtar
    end

    set --local failed false

    for file in $argv
        switch $file
            case '*.tar'
                $tar xvf "$file"

            case '*.tar.gz' '*.tgz'
                $tar xvzf "$file"

            case '*.tar.bz2' '*.tar.bz' '*.tbz' '*.tbz2'
                $tar xvjf "$file"

            case '*.tar.xz' '*.txz'
                $tar xvJf "$file"

            case '*.tar.Z' '*.taz'
                $tar xvZf "$file"

            case '*.tar.zst' '*.tzst'
                $tar --zstd -xvf "$file"

            case '*.tar.lzma' '*.tar.zma' '*.tlz'
                $tar --lzma -xvf "$file"

            case '*.tar.lrz'
                lrzuntar "$file"

            case '*.tar.lz'
                $tar --lzip -xvf "$file"

            case '*.tar.lz4'
                $tar --use-compress-program=lz4 -xvf "$file"

            case '*.tar.lzo'
                $tar --lzop -xvf "$file"

            case '*.7z' '*.iso'
                7zz x "$file"

            case '*.gz'
                gunzip --keep "$file"

            case '*.bz2' '*.bz'
                bunzip2 --keep "$file"

            case '*.xz'
                unxz --keep "$file"

            case '*.lrz'
                lrunzip "$file"

            case '*.lz4'
                unlz4 "$file" (string replace --regex '\.lz4$' '' "$file")

            case '*.lzma'
                unlzma --keep "$file"

            case '*.zip' '*.xpi' '*.jar'
                unzip "$file"

            case '*.Z'
                uncompress -k "$file"

            case '*.zst'
                unzstd --keep "$file"

            case '*.zz'
                unpigz --keep "$file"

            case '*'
                echo >&2 "extract: failed to extract '$file': no extractor implemented for file type"
                set failed true
                continue
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
