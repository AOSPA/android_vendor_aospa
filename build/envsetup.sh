function __print_aospa_functions_help() {
cat <<EOF
Additional Paranoid Android functions:
- cafmerge:        Utility to merge CAF tags.
EOF
}

function cafmerge()
{
    target_branch=$1
    set_stuff_for_environment
    T=$(gettop)
    python3 $T/vendor/aospa/scripts/merge-caf.py $target_branch
}

export SKIP_ABI_CHECKS="true"
