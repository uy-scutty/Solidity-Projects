// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract SimpleStorage {

    struct User {
        uint256 number;
        string name;
        bool registered; // default is false
    }

    address owner;

    constructor () {
        owner = msg.sender;
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


    function getUser (address _user) view public returns (uint256, string memory) {
        require(users[_user].registered, "user not registered");

        User memory user = users[_user];
        return (user.number, user.name);
    }


    function getAllUsers () public view returns (User[] memory) {
        require (msg.sender == owner, "Only admin can call this function");

        uint256 length = userList.length; // checks the ammount of users registered
        User[] memory allUsers = new User[](length); // creates a new array to store those registered users 

        for (uint256 i = 0; i < length; i++) {
            address userAddress = userList[i];
            allUsers[i] = users[userAddress];
        }

        return allUsers;
    }
}    