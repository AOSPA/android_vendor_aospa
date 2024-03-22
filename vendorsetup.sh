# Shebang is intentionally missing - do not run as a script

# Override host metadata to make builds more reproducible and avoid leaking info
export BUILD_USERNAME=nobody
export BUILD_HOSTNAME=android-build

echo "Building with ThinLTO."
export GLOBAL_THINLTO=true
export USE_THINLTO_CACHE=true
