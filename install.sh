#!/usr/bin/env bash

set -x
set -u
set -e

GITHUB_DIR=$HOME/code/src/github.com
INSTALLSD_DIR=$GITHUB_DIR/installsd.git

mkdir -p $GITHUB_DIR
[ ! -d "$INSTALLSD_DIR" ]  && git clone https://github.com/crowz-fx/installsd.git $INSTALLSD_DIR || echo "Repo exists, skipping clone!"
cd $INSTALLSD_DIR/
chmod 744 $INSTALLSD_DIR/Makefile $INSTALLSD_DIR/makefile.sh
echo "Ready to run your make commands..."
