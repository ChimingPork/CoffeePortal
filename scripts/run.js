const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const coffeeContractFactory = await hre.ethers.getContractFactory("CoffeePortal"); //Compile contract and generate files under artifacts
    const coffeeContract = await coffeeContractFactory.deploy(); //Hardhat creates local ETH network for this contract. After script completes will destroy local network
    //This allows a fresh blockchain to be used everytime we run the contract
    await coffeeContract.deployed(); //Wait until contract is actually deployed before running constructor

    console.log("Contract deployed to:", coffeeContract.address); //Once deployed, provide with address of contract so we can find on blockchain
    console.log("Contract delpoyed by:", owner.address); // Will also provide address of who deployed it

    //Manually call coffee functions
    let coffeeCount;
    coffeeCount = await coffeeContract.getTotalCoffees(); //Call function to count total coffees

    let coffeeTxn = await coffeeContract.coffee(); //Call function to do the coffee transaction and change the state variable
    await coffeeTxn.wait();

    coffeeCount = await coffeeContract.getTotalCoffees(); //Call function to count coffees again to see if it has changed

    coffeeTxn = await coffeeContract.connect(randomPerson).coffee(); //Simulate other people calling coffee function
    await coffeeTxn.wait();

    coffeeCount = await coffeeContract.getTotalCoffees();

    //Manually call donut functions
    let donutCount;
    donutCount = await coffeeContract.getTotalDonuts(); 

    let donutTxn = await coffeeContract.donut(); 
    await donutTxn.wait();

    donutCount = await coffeeContract.getTotalDonuts(); 

    donutTxn = await coffeeContract.connect(randomPerson).donut(); 
    await donutTxn.wait();

    donutCount = await coffeeContract.getTotalDonuts();
};

const runMain = async () => {
    try {
        await main();
        process.exit(0); // exit Node process without error
    } catch (error) {
        console.log(error);
        process.exit(1); // exit Node process while indication 'Uncaught Fatal Exception' error
    }
};

runMain();