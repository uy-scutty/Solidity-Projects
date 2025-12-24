
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 minimumUsd = 5;


    address owner;

    constructor() {
        owner = msg.sender;
    }

    mapping (address => uint256 ) public ammountFunded; // keeps tract of how much each address donates
    address [] public funders; // stores all donors address



    function fund (uint256 _amount) public payable  {
        require (_amount > minimumUsd, "Not enough of ETH");
        ammountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    
    }

    function getPrice () public {
        // address  get this from chainlink
        // ABI
    }

    function getConversion () view public {

    }

    function withdraw () view public {
        require (msg.sender == owner, "Only admin can withdraw funds");
    }
}