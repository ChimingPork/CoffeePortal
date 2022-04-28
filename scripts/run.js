const main = async () => {
    const coffeeContractFactory = await hre.ethers.getContractFactory("CoffeePortal"); //Compile contract and generate files under artifacts
    const coffeeContract = await coffeeContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    }); 
    //Hardhat creates local ETH network for this contract. After script completes will destroy local network
    //This allows a fresh blockchain to be used everytime we run the contract
    
    await coffeeContract.deployed(); //Wait until contract is actually deployed before running constructor
    console.log("Contract deployed to:", coffeeContract.address); //Once deployed, provide with address of contract so we can find on blockchain

    //Get contract balance
    let contractBalance = await hre.ethers.provider.getBalance(coffeeContract.address);
    console.log("Contract Balance:", hre.ethers.utils.formatEther(contractBalance));

    let coffeeTxn = await coffeeContract.coffee("A Coffee!"); //Call function to do the coffee transaction and change the state variable
    await coffeeTxn.wait(); // wait for transaction t be mined

    //Get Balance Again
    contractBalance = await hre.ethers.provider.getBalance(coffeeContract.address);
    console.log("Contract Balance:", hre.ethers.utils.formatEther(contractBalance));

    let donutTxn = await coffeeContract.donut("A Donut!"); 
    await donutTxn.wait();
    
    //Get Balance Again
    contractBalance = await hre.ethers.provider.getBalance(coffeeContract.address);
    console.log("Contract Balance:", hre.ethers.utils.formatEther(contractBalance));
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

/*
When updating contract, remeber to do these things:
1. We need to deploy it again.
2. We need to update the contract address on our frontend.
3. We need to update the abi file on our frontend. 
*/