## standup the local hotpocket listening on port 8081 to run your contract
cd ../contract

npm install

#calls hpdevkit deploy dist
#which will standup hot pocket cluster and deploy to local cluster
npm start 

#view logs from other nodes
#hpdevkit logs 2



#When it's running & logging, open a new terminal and launch ../client/start_local.sh