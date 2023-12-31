# Project Overview
This project includes a simple Evernode contract and a client that interacts with the contract.

## Prerequisites
Before you start, ensure you have the following installed:
- [Node.js](https://nodejs.org/en/download)
- [Docker](https://www.docker.com/get-started/)

After installing Node.js and Docker, install the HotPocket and Evernode development kits using the following commands:
```bash
npm i hpdevkit -g
npm i evdevkit -g

## Running the Project Locally
To run the contract and client locally, execute the following commands in two different terminals. Ensure the contract starts logging before launching the client:

./deploy/deploy_local.sh 
./client/start_local.sh 


## Deploying the Contract to Hosted Servers

To deploy your contract to hosted servers, run the following command. This will bundle and deploy the contract to the nftstiches.com Evernode host and then launch a client to send a hello message to it:

./deploy/deploy_remote.sh


## Note

The keys in this project are all test keys.

``{
  "fromClassicAddress": "rDYV4ckh3X71oqaAT2MuSrCbyQHq8TJLyE",
  "userSeed": "ssJjfgyqSer5Vmzb4YfhFdEtAX4Ve"
}``

You can generate a different set of keys with evers and update EV_TENANT_SECRET at the top of deploy/deploy_remote.sh script with your seed

- https://dashboard.evernode.org/#/testnet-faucet

Validate your address here.  Replace your address in the URL

- https://explorer.xahau-test.net/rDYV4ckh3X71oqaAT2MuSrCbyQHq8TJLyE/lines



Here is the user private key used in the project

``New key pair generated {
  privateKey: 'ed4bbeeb627fb0e1ad6b30aba850bf31f34d6061b907865e92375c50b0d19fcbf03892a9962ac42a37e28221fae7ce102d03ca0b6776890999d1b5a665d3f94bb5',
  publicKey: 'ed3892a9962ac42a37e28221fae7ce102d03ca0b6776890999d1b5a665d3f94bb5'
}``

You can generate your own user private key with the following command.  Update EV_USER_PRIVATE_KEY at the top of deploy/deploy_remote.sh with your privateKey 

- evdevkit keygen









# Docs:

- https://docs.evernode.org/en/latest/
- https://github.com/EvernodeXRPL/evernode-sdk/blob/main/hotpocket/tutorial-basics.md





If you are using windows you might want to install git bash or something to run the start and deploy scripts in there.   Otherwise you can update the scripts 
so the environment variables are set with the windows syntax.  For example

$env:EV_TENANT_SECRET='ssJjfgyqSer5Vmzb4YfhFdEtAX4Ve'


When you make changes to your contract code, you will need to run npm start in the contract directory which will update the dist/index.js with your new code.