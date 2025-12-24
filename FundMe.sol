
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 constant minimumUsd = 5;

    AggregatorV3Interface public immutable priceFeed;


    address owner;

    constructor(address _chainAddress) {// address  get this from chainlink  that's what am passing
        owner = msg.sender;
        priceFeed= AggregatorV3Interface(_chainAddress);
    } 

    mapping (address => uint256 ) public ammountFunded; // keeps tract of how much each address donates
    address [] public funders; // stores all donors address



    function fund (uint256 _amount) public payable  {
        require (_amount > minimumUsd, "Not enough of ETH");
        ammountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getPrice  () view  public returns (int256 price) {
        
        // ABI
        (, int256 price, , ,)= priceFeed.latestRoundData ();
        return price;
    }

    function getConversion ()  view public {
        
    }

    function withdraw () view public {
        require (msg.sender == owner, "Only admin can withdraw funds");
    }
}