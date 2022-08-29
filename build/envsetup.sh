function __print_aospa_functions_help() {
cat <<EOF
Additional Paranoid Android functions:
- clomerge:        Utility to merge CLO tags.
- repopick:        Utility to fetch changes from Gerrit.
EOF
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

export SKIP_ABI_CHECKS="true"
