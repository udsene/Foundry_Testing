//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract Auction {

    uint256 public startAt;
    uint256 public endAt;


    constructor() payable {
        startAt = block.timestamp + 1 days;
        endAt = block.timestamp + 2 days;
    }
    function bid() public view {
        require(block.timestamp >= startAt && block.timestamp < endAt, "revert bid");
    }

    function end() public view {
        require(block.timestamp >= endAt);
    }


}