function __print_aospa_functions_help() {
cat <<EOF
Additional Paranoid Android functions:
- clodiff:         Utility to diff CLO history to AOSPA.
- clomerge:        Utility to merge CLO tags.
- repopick:        Utility to fetch changes from Gerrit.
- sort-blobs-list: Sort proprietary-files.txt sections with LC_ALL=C.
EOF
}

# check to see if the supplied product is one we can build
function check_product()
{
    local T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
        return
    fi
    if (echo -n $1 | grep -q -e "^aospa_") ; then
        AOSPA_BUILD=$(echo -n $1 | sed -e 's/^aospa_//g')
    else
        AOSPA_BUILD=
    fi
    export AOSPA_BUILD

        TARGET_PRODUCT=$1 \
        TARGET_BUILD_VARIANT= \
        TARGET_BUILD_TYPE= \
        TARGET_BUILD_APPS= \
        get_build_var TARGET_DEVICE > /dev/null
    # hide successful answers, but allow the errors to show
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
