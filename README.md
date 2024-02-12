Uses `nsupdate` to set a comma seperated list of domains IPs to target hostname.

ex: `docker run --rm -e KEY_BYTES='hmac-sha256:key-name:base64keysecret' -e DOMAINS='example.com,sub.example.com,example3.com' -e TARGET_HOST='mydynamic.ip.com' -e MY_DNS_SERVER=192.168.86.111 theempty/nsupdate-ddns`

