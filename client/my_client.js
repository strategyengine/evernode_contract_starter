const HotPocket = require('hotpocket-js-client');
const fs = require('fs');

async function clientApp() {

    const userKeyPair = await keypair();// await HotPocket.generateKeys();

    var cnx = process.env.EV_CLIENT_CONNECTION;

    if(!cnx){
        cnx = "wss://nftstitches.com:26220"
    }

    const client = await HotPocket.createClient([cnx], userKeyPair);


    // Establish HotPocket connection.
    if (!(await client.connect())) {
        console.log("Connection failed. " + cnx);
        return;
    }

    console.log("Connection established " + cnx);

    // Register event handler to receive outputs before we start sending inputs.
    //can be called many times
    client.on(HotPocket.events.contractOutput, (result) => {
        console.log("Received outputs:");
        result.outputs.forEach((o) => console.log(o));
    });

    //    const balance = await client.getEVRBalance();

    console.log("Saying hello from - evr client:" + Buffer.from(userKeyPair.publicKey).toString('hex'));
    await client.submitContractInput("hello");

    console.log("HotPocket Connected.");
    console.log("Saying hello...");
    //  await client.submitContractReadRequest("hello");
}


async function keypair() {

    const keyFile = 'user.key';
    if (!fs.existsSync(keyFile)) {
        const newKeyPair = await HotPocket.generateKeys();
        const saveData = Buffer.from(newKeyPair.privateKey).toString('hex');
        fs.writeFileSync(keyFile, saveData);
        console.log('New key pair generated.');
    }

    // Generate the key pair using saved private key data.
    const savedPrivateKeyHex = fs.readFileSync(keyFile).toString();
    const userKeyPair = await HotPocket.generateKeys(savedPrivateKeyHex);

    return userKeyPair;
}


clientApp();