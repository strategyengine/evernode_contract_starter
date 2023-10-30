#You can use this seed or replace it with your own.  See the ../README.txt
export EV_TENANT_SECRET='ssJjfgyqSer5Vmzb4YfhFdEtAX4Ve'
#You can use this private key or generate your own.  See the ../README.txt
export EV_USER_PRIVATE_KEY='ed4bbeeb627fb0e1ad6b30aba850bf31f34d6061b907865e92375c50b0d19fcbf03892a9962ac42a37e28221fae7ce102d03ca0b6776890999d1b5a665d3f94bb5'
export EV_INSTANCE_CONFIG_PATH="$(pwd)/hp.cfg"

echo "Config path: $EV_INSTANCE_CONFIG_PATH"

EV_CLIENT_BUNDLE_PUBKEY=$(evdevkit acquire -h 'rELmLu8zDrY6ts4PLNwtvjHjgE8QCkXmhw' | grep -E "pubkey:" | awk '{print $2}' | tr -d "',")

echo "evdevkit acquire pubkey: $EV_CLIENT_BUNDLE_PUBKEY"

cd ../contract
npm install

echo 'npm install complete'

#Acquire connection to evernode host, bundle and deploy.  rELmLu8zDrY6ts4PLNwtvjHjgE8QCkXmhw is the nftstitches.com evernode host. You can remove this -h param if you like
evdevkit bundle . $EV_CLIENT_BUNDLE_PUBKEY /usr/bin/node -a dist/index.js
echo 'evdevkit bundle complete'
EV_CLIENT_CNX_PARAMS=$(evdevkit acquire -h 'rELmLu8zDrY6ts4PLNwtvjHjgE8QCkXmhw')
#uncomment for random host
#EV_CLIENT_CNX_PARAMS=$(evdevkit acquire)


# Use grep with regular expressions to extract the values
EV_CLIENT_PUBKEY=$(echo "$EV_CLIENT_CNX_PARAMS" | grep -oP "pubkey:\s*'([^']*)'" | sed "s/pubkey: '//" | tr -d "'" )

EV_CLIENT_PORT=$(echo "$EV_CLIENT_CNX_PARAMS" | grep -oP "user_port:\s*'([^']*)'" | sed "s/user_port: '//" | tr -d "'")

EV_CLIENT_DOMAIN=$(echo "$EV_CLIENT_CNX_PARAMS" | grep -oP "domain:\s*'([^']*)'" | sed "s/domain: '//" | tr -d "'")


echo "EV_CLIENT_CNX_PARAMS: $EV_CLIENT_CNX_PARAMS"
# Construct the EV_CLIENT_CONNECTION variable
EV_CLIENT_CONNECTION="wss://${EV_CLIENT_DOMAIN}:${EV_CLIENT_PORT}"

echo "EV_CLIENT_CONNECTION: $EV_CLIENT_CONNECTION"
echo "EV_CLIENT_PUBKEY: $EV_CLIENT_PUBKEY"

cd ../bundle
echo "$(ls)"
echo "Deploying bundle.zip to $EV_CLIENT_DOMAIN $EV_CLIENT_PORT"
evdevkit deploy bundle.zip $EV_CLIENT_DOMAIN $EV_CLIENT_PORT
echo "Deployment bundle.zip complete"




# Export the variables
export EV_CLIENT_CONNECTION
export EV_CLIENT_PUBKEY


## start the client
cd ../client
npm install

node my_client.js




