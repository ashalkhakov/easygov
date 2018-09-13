#!/bin/bash -e

mkdir -p /usr/local/share/ca-certificates/egov
chmod 755 /usr/local/share/ca-certificates/egov
cd /usr/local/share/ca-certificates/egov

for certname in pki_rsa pki_gost root_rsa root_gost nca_rsa nca_gost
do
    wget "http://root.gov.kz/root_cer/$certname.crt"
done

for revlistname in rsa gost nca_rsa nca_gost
do
    wget "http://crl.pki.gov.kz/$revlistname.crl"
done

chmod 644 *.cr?
update-ca-certificates
