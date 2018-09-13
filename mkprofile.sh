#!/bin/bash -e

# create the profile so we have something to import certs into
echo creating the profile!
# NOTE: must be the same as in [container_startup.sh]!
firefoxProfile="$HOME/.mozilla/firefox/m4v6pi7q.profile"
mkdir -p "$firefoxProfile"

# install certs into firefox...
# a) copy into accessible location
cd $firefoxProfile
echo copying certs

mkdir -p $HOME/egov-certs
sudo cp /usr/local/share/ca-certificates/egov/* $HOME/egov-certs/
sudo chown -R $USER:$USER $HOME/egov-certs

# b) add to profile's security db
echo importing certs

certutil -d sql:. -N --empty-password

# NOTE: pki_gost root_gost nca_gost -- these cannot be added!
for cert in pki_rsa root_rsa nca_rsa
do
    # CA file to install
    certfile="$HOME/egov-certs/$cert.crt"
    certname="$cert"

    # For cert9 (SQL)
    echo importing $certfile
    certutil -A -n "$certname" -t "C,," -i "$certfile" -d sql:.
done
