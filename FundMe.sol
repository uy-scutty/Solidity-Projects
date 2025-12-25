
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 constant minimumUsd = 5;

    AggregatorV3Interface public immutable priceFeed;


    address immutable owner;

    constructor(address _chainAddress) {// address  get this from chainlink  that's what am passing
        owner = msg.sender;
        priceFeed= AggregatorV3Interface(_chainAddress);
    } 

    mapping (address => uint256 ) public amountFunded; // keeps tract of how much each address donates
    address [] public funders; // stores all donors address



    function fund () external  payable  {
        uint256 ethInUsd =  getConversion(msg.value); // takes the amount of eth i want to deposit and converts to dollars
        require ( ethInUsd >= minimumUsd * 1e18, "Not enough of ETH"); // compares that dollar to set minimun
        amountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getPrice  () view  public returns (int256) {
        (, int256 price, , ,)= priceFeed.latestRoundData ();
        return price;
    }

    function getConversion (uint256 _ethAmount)  view public returns (uint256) {
        int256 rawPrice = getPrice();
        require(rawPrice > 0, "Invalid Price");

        uint256 price = uint256(rawPrice);

        return (price * _ethAmount) / 1e8;
    }


    // function withdraw () public {
    //     require(msg.sender == owner, "You don't own this contract");
    //     uint256 amount = address(this).balance;
    //     (bool success, ) = owner.call{value: amount}("");
    //     require(success, "ETH transfer failed");


    // }


    function withdraw() external {
    require(msg.sender == owner, "You don't own this contract");

    uint256 amount = address(this).balance;
    require(amount > 0, "No ETH to withdraw");

    (bool success, ) = owner.call{value: amount}("");
    require(success, "ETH transfer failed");
}

}