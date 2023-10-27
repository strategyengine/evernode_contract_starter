const HotPocket = require("hotpocket-nodejs-contract");
const fs = require("fs").promises;

const my_contract = async (ctx) => {


    console.log("Ledger number", ctx.lclSeqNo);
    console.log("Connected users", ctx.users.count());
    for (const user of ctx.users.list()) {
        console.log("User public key", user.publicKey);
        // Loop through inputs sent by the user.
        for (const input of user.inputs) {
            const buffer = await ctx.users.read(input);



            const message = buffer.toString();
            console.log("Received input:", message);

            // Save the input to a user-specific file name.
            const filename = `${user.publicKey}.log`;
            await fs.appendFile(filename, message + "\n");

            // Get total no. of messages sent by user so far.
            const allMessages = (await fs.readFile(filename)).toString();
            const total = allMessages.split("\n").length - 1;

            user.send(`You said '${message}'`);

            // Include total message count in the reply.
            user.send(`Thanks for talking to me ${total} times`);
        }
    }



}

const hpc = new HotPocket.Contract();
hpc.init(my_contract);