// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CoffeePortal {
    uint256 totalCoffees;

    constructor() {
        console.log("This is a smart contract");
    }

    function giveCoffee() public {
        totalCoffees += 1;
        console.log("%s has given a coffee!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We've had %d cups of coffee!", totalCoffees);
        return totalCoffees;
    }
}