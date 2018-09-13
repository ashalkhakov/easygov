#!/bin/bash -e

# start ncalayer
/ncalayer/NCALayer/ncalayer.sh --run &

# NOTE: must be the same as in [mkprofile.sh]!
/opt/mkprofile.sh
firefoxProfile="$HOME/.mozilla/firefox/m4v6pi7q.profile"

#
# finally, start the browser!
#
cd
/usr/bin/firefox --profile "$firefoxProfile" --no-remote "${@}"
