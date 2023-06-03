//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {

    address payable public  owner;

    event transfer(address from, uint256 value);
    
    constructor () payable {
        owner = payable(msg.sender);
    }

    receive() payable external {
        emit transfer(msg.sender, msg.value);
    }

    function withdraw (uint256 _amount) external {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external {
        require(msg.sender == owner, "Caller is not the owner");
        owner = payable(_owner);
    }
}