// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


// has mutiple users
//store number and name
// only owner can reset
// emit events


contract SimpleStorage {

    struct User {
        uint256 number;
        string name;
        bool registered; // default is false
    }

    mapping (address => User) public users; // connects address to user
    address[] public userList; // stores all users/ registered address

    modifier register (string memory _name) {
        require(bytes(_name).length >= 3, "Name is not long enough");
        require(!users[msg.sender].registered, "User already registered"); // since default is false !default is true
        _;
    }   

    function registerUser (uint256 _number, string memory _name) register(_name) public  {   
        users[msg.sender] = User (_number, _name, true);
        userList.push(msg.sender);
    }
}