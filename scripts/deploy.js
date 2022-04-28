const main = async () => {
    const coffeeContractFactory = await hre.ethers.getContractFactory("CoffeePortal");
    const coffeeContract = await coffeeContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.01"),
    });
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