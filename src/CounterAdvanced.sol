//SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract CounterAdvanced {
    uint256 public counter;

    function getCounter() public view returns(uint256) {
        return counter;
    }
    function inc() public {
        counter += 1;
    }

    function dec() public {
        counter -= 1;
    }
}