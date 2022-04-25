// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CoffeePortal {
    uint256 totalCoffees; //automatically initialized to 0, "state variable"
    uint256 totalDonuts;

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

    constructor() {
        console.log("Successfully deployed the smart contract");
    }

    function coffee(string memory _message) public {
        totalCoffees += 1;
        console.log("%s has given a coffee!", msg.sender, _message); // wallet address of person who called function

        // Here is where we store the coffee data in the array
        coffees.push(Coffee(msg.sender, _message, block.timestamp));
        emit NewCoffee(msg.sender, block.timestamp, _message);
    }

    function donut(string memory _message) public {
        totalDonuts += 1;
        console.log("%s has given a donut!", msg.sender); // wallet address of person who called function
        donuts.push(Donut(msg.sender, _message, block.timestamp));
        emit NewDonut(msg.sender, block.timestamp, _message);
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