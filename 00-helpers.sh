#
# DecryptFileTo SRC-PATH DST-PATH [MODE [OWNER [GROUP]]]
#
# Decrypts with gpg and copies a file from the "files" subdirectory
# to the output, under a different name or path.
#
# The source path should be relative to the root of the "files" subdirectory.
# The destination path is relative to the root of the output directory.
#

function DecryptFileTo() {
    local src_file="$1"
    local dst_file="$2"
    local mode="${3:-}"
    local owner="${4:-}"
    local group="${5:-}"

    if [[ "$src_file" != /* ]]
    then
        Log "%s: Source file path %s is not absolute.\n" \
            "$(Color Y "Warning")" \
            "$(Color C "%q" "$src_file")"
        config_warnings+=1
    fi

    if [[ "$dst_file" != /* && "$dst_file" != "$src_file" ]]
    then
        Log "%s: Target file path %s is not absolute.\n" \
            "$(Color Y "Warning")" \
            "$(Color C "%q" "$dst_file")"
        config_warnings+=1
    fi

    mkdir --parents "$(dirname "$output_dir"/files/"$dst_file")"

    gpg \
        --output "$output_dir"/files/"$dst_file" \
        --decrypt \
       "$config_dir"/files/"$src_file"

    SetFileProperty "$dst_file" mode  "$mode"
    SetFileProperty "$dst_file" owner "$owner"
    SetFileProperty "$dst_file" group "$group"

    used_files["$src_file"]=y
}
