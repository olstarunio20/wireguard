#!/bin/sh
# Powered by: PisoVPN
# Feel free to fork.



c1=""
echo ""
echo "Username"
read c1
echo ""

clear

rm -rf privatekey publickey warp.json *.conf warpx.sh *.zip

wg genkey | tee privatekey | wg pubkey > publickey

pub=$(cat publickey)
priv=$(cat privatekey)
#x="s/pubx/$pub/g";

cat << EOF > warpx.sh
#!/bin/sh


curl -d '{"key":"$pub", "install_id":"", "warp_enabled":true, "tos":"2019-09-26T00:00:00.000+01:00", "type":"Android", "locale":"en_GB"}' https://api.cloudflareclient.com/v0a737/reg | tee warp.json


EOF


chmod +x warpx.sh
./warpx.sh


cat << EOF > client-$c1.conf
[Interface]
Address = 172.16.0.2/32
DNS = 1.1.1.1
PrivateKey = $priv

[Peer]
AllowedIPs = 0.0.0.0/1, 128.0.0.0/1
Endpoint = engage.cloudflareclient.com:2408
PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
EOF



zip client-$c1.zip client-$c1.conf


clear

echo "please download your config at root directory"


rm -rf privatekey publickey warp.json *.sh *.conf
