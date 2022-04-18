const main = async () => {
    const coffeeContractFactory = await hre.ethers.getContractFactory("CoffeePortal"); //Compile contract and generate files under artifacts
    const coffeeContract = await coffeeContractFactory.deploy(); //Hardhat creates local ETH network for this contract. After script completes will destroy local network
    //This allows a fresh blockchain to be used everytime we run the contract
    await coffeeContract.deployed(); //Wait until contract is actually deployed before running constructor
    console.log("Contract deployed to:", coffeeContract.address); //Once deployed, provide with address of contract so we can find on blockchain
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