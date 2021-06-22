#!/bin/bash
pushd tor-build
docker build -t tor .
popd
pushd firefox-build
docker build -t firefox .
popd
