if [[ $(uname) == Darwin ]]; then
    # note, conda-forge-ci-setup's run_conda_forge_build_setup_osx
    # exports MACOS_DEPLOYMENT_TARGET based on value seen in conda-build-config.yaml
    # exports CONDA_BUILD_SYSROOT based on MACOSX_DEPLOYMENT_TARGET
    # will repeat check for CONDA_BUILD_SYSROOT here since we're using it in our
    # cmake flags
    if [ -d "${CONDA_BUILD_SYSROOT}" ]; then
	echo "Found CONDA_BUILD_SYSROOT: ${CONDA_BUILD_SYSROOT}"
    else
	echo "Missing CONDA_BUILD_SYSROOT: ${CONDA_BUILD_SYSROOT}"
	exit 1
    fi

    CMAKE_EXTRA="-DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT}"
else
    CMAKE_EXTRA=""
fi


mkdir -p sparta/release
pushd sparta/release
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH="$PREFIX" "$CMAKE_EXTRA" ..
cmake --build . --target

popd
