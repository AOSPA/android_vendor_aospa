function __print_aospa_functions_help() {
cat <<EOF
Additional Paranoid Android functions:
- clodiff:         Utility to diff CLO history to AOSPA.
- clomerge:        Utility to merge CLO tags.
- repopick:        Utility to fetch changes from Gerrit.
- sort-blobs-list: Sort proprietary-files.txt sections with LC_ALL=C.
EOF
}

function clodiff()
{
    target_branch=$1
    set_stuff_for_environment
    T=$(gettop)
    python3 $T/vendor/aospa/build/tools/diff-clo.py $target_branch
}

function clomerge()
{
    target_branch=$1
    set_stuff_for_environment
    T=$(gettop)
    python3 $T/vendor/aospa/build/tools/merge-clo.py $target_branch
}

function kernelmanifestgen()
{
    T=$(gettop)
    source $T/vendor/aospa/vars/kplatform

    if [ -n "$ZSH_VERSION" ]; then
        keys=(${(k)KPLATFORM_ARRAY[@]})
    else
        keys=(${!KPLATFORM_ARRAY[@]})
    fi

    for code in "${keys[@]}"; do
        python3 $T/vendor/aospa/build/tools/kernel-manifest-generator.py \
            "${KPLATFORM_ARRAY[$code]}" \
            "$T/vendor/aospa/products/platforms/$code-kernel"
    done
}

function repopick()
{
    T=$(gettop)
    $T/vendor/aospa/build/tools/repopick.py $@
}

function sort-blobs-list() {
    T=$(gettop)
    $T/tools/extract-utils/sort-blobs-list.py $@
}

export SKIP_ABI_CHECKS="true"
