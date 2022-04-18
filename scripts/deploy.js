const main = async () => {
    const [deployer] = await Headers.ethers.getSigners();
    const accountBalance = await deployer.getBalance();

    console.log("Deploying contracts with account: ", deployer.address);
    console.log("Account balance: ", accountBalance.toString());

    const coffeeContractFactory = await hre.ethers.getContractFactory("CoffeePortal");
    const coffeeContract = await coffeeContractFactory.deploy();
    await coffeeContract.deployed();

    console.log("CoffeePortal address: ", coffeeContract.address);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error) 
        process.exit(1);
    }
}

runMain();