// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.5.0/contracts/token/ERC20/ERC20.sol";



contract erc is ERC20 {
     constructor(uint256 initialSupply) ERC20("Scutty", "UYS") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }
}