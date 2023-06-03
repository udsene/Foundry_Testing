//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract Event {

    event logTransfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address from, address to, uint256 amount) public {
        emit logTransfer(from, to, amount);
    }

    function transferMany(address from, address[] calldata to, uint256[] calldata amount) public {
        uint256 i;
        for(i; i < to.length; ++i){
            emit logTransfer(from, to[i], amount[i]);
        }
    }
}