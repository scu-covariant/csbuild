#!/bin/bash
function start ()
{
    cd $1
    CS_DEV_PATH=../../covscript/csdev bash $2
    cd ..
}
mkdir -p build-cache
cd build-cache
git_repo=https://github.com/covscript
function fetch_git ()
{
    if [ ! -d "$1" ]; then
        git clone $git_repo/$1
    else
        cd $1
        git fetch
        git pull
        git clean -dfx
        cd ..
    fi
}
git_edu_repo=https://github.com/scu-covariant
function fetch_git_edu ()
{
    if [ ! -d "$1" ]; then
        git clone $git_edu_repo/$1
    else
        cd $1
        git fetch
        git pull
        git clean -dfx
        cd ..
    fi
}
fetch_git cspkg &
fetch_git_edu covscript &
fetch_git covscript-regex &
fetch_git covscript-codec &
fetch_git covscript-darwin &
fetch_git covscript-sqlite &
fetch_git covscript-network &
fetch_git covscript-streams &
fetch_git covscript-imgui &
wait
start covscript "./csbuild/make.sh"
start covscript "./csbuild/install.sh"
start covscript-regex "./make.sh" &
start covscript-codec "./make.sh" &
start covscript-darwin "./make.sh" &
start covscript-sqlite "./make.sh" &
start covscript-network "./make.sh" &
start covscript-streams "./make.sh" &
start covscript-imgui "./make.sh" &
wait