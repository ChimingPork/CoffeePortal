// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CoffeePortal {
    uint256 totalCoffees; //automatically initialized to 0, "state variable"
    uint256 totalDonuts;

    constructor() {
        console.log("This is a smart contract");
    }

    function coffee() public {
        totalCoffees += 1;
        console.log("%s has given a coffee!", msg.sender); // wallet address of person who called function
    }

    function donut() public {
        totalDonuts += 1;
        console.log("%s has given a donut!", msg.sender); // wallet address of person who called function
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