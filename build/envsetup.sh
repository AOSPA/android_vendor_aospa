function __print_aospa_functions_help() {
cat <<EOF
Additional Paranoid Android functions:
- cafmerge:        Utility to merge CAF tags.
- repopick:        Utility to fetch changes from Gerrit.
EOF
}

function cafmerge()
{
    target_branch=$1
    set_stuff_for_environment
    T=$(gettop)
    python3 $T/vendor/aospa/build/tools/merge-caf.py $target_branch
}

function repopick()
{
    T=$(gettop)
    $T/vendor/aospa/build/tools/repopick.py $@
}

export SKIP_ABI_CHECKS="true"
export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true

# Enable ThinLTO Source wide.
echo "Building with ThinLTO."
export GLOBAL_THINLTO=true
export USE_THINLTO_CACHE=true
