// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CoffeePortal {
    uint256 totalCoffees; //automatically initialized to 0, "state variable"
    uint256 totalDonuts;
    uint256 private seed;

    /* Event is inheritable emember of contract. 
    Event is emitted and logs are stored on blockchain. Not accessible from within contract
    logs are accessible using address of contract until the contract is present on the blockchain
    */

    event NewCoffee(address indexed from, uint256 timestamp, string message);
    event NewDonut(address indexed from, uint256 timestamp, string message);

    struct Coffee {
        address coffeeUser; //Address of coffee drinker
        string message; // message of coffee drinker
        uint256 timestamp; // Timestamp when they had a coffee
    }

    struct Donut {
        address donutUser;
        string message;
        uint256 timestamp;
    }
    
    // Create an array to store all the structs
    Coffee[] coffees;
    Donut[] donuts;

    //address => uint mapping meaning I can associate an address with a number, in this case last time we minted a Goodie
    mapping(address => uint256) public lastMintGoodie;
    constructor() payable {
        console.log("Successfully deployed the smart contract");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function coffee(string memory _message) public {
        //Make sure there are at least 15 mins between mints
        require(
            lastMintGoodie[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        //Update current user timestamp
        lastMintGoodie[msg.sender] = block.timestamp;

        totalCoffees += 1;
        console.log("%s has minted a coffee!", msg.sender, _message); // wallet address of person who called function

        // Here is where we store the coffee data in the array
        coffees.push(Coffee(msg.sender, _message, block.timestamp));
        //emit the event so we can use it in our Dapp

        // Generate new seed for next user
        seed = (block.difficulty + block.timestamp + seed) %100;
        console.log("Random # generated: %d", seed);

        //Give 50% chance to win prize
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
    emit NewCoffee(msg.sender, block.timestamp, _message);
    }

    function donut(string memory _message) public {
        
        require(
            lastMintGoodie[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        lastMintGoodie[msg.sender] = block.timestamp;

        totalDonuts += 1;
        console.log("%s has minted a donut!", msg.sender); // wallet address of person who called function
        donuts.push(Donut(msg.sender, _message, block.timestamp));
        
        seed = (block.difficulty + block.timestamp + seed) %100;
        console.log("Random # generated: %d", seed);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        emit NewDonut(msg.sender, block.timestamp, _message);
    }

    function getAllCoffees() public view returns (Coffee[] memory) {
        return coffees;
    }

    function getAllDonuts() public view returns (Donut[] memory) {
        return donuts;
    }

    function getTotalCoffees() public view returns (uint256) {
        console.log("We've had %d cups of coffee!", totalCoffees);
        return totalCoffees;
    }

    function getTotalDonuts() public view returns (uint256) {
        console.log("We've eaten %d tasty donuts!", totalDonuts);
        return totalDonuts;
    }
}