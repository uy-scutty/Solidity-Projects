// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Token {

    string public name = "Scutty";
    string public symbol = "UYS";
    uint8 public decimals = 10;


    uint256 public totalSupply;

    event Transfer (address indexed from, address indexed to, uint value);
    event Approval (address indexed owner, address indexed spender, uint value);

    mapping (address => uint) public  balanceOf;
    mapping (address => mapping (address => uint) ) allowance;


    constructor (uint initialSupply) {
        totalSupply = initialSupply * 10 ** decimals;
        balanceOf[msg.sender] += totalSupply;
        emit Transfer(address(0),msg.sender, totalSupply);
    }

   

    function transfer (address to, uint _amount) public returns (bool) {
        require(balanceOf[msg.sender] >= _amount, "Insufficeint Amount");
        require(to != address(0), "Invalid Account");

        balanceOf[msg.sender] -= _amount;
        balanceOf[to] += _amount;

        emit Transfer(msg.sender, to, _amount);
        return true;

    }

    function approve (address spender, uint256 amount ) external  returns (bool) {
        allowance[msg.sender][spender] = amount;  
        emit Approval(msg.sender, spender, amount); 
        return true;              

    }
    
    function transferFrom (address from, address to, uint256 amount) external returns (bool) {
        require (balanceOf[from] >= amount, "Insufficient Funds");
        require (allowance[from][msg.sender] >= amount, "Limit exceeded");
        require (to != address(0), "Invalid Account");

        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);
        return true;
        
    }

}