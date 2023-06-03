//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Event} from "../src/Event.sol";

contract EventTest is Test {

    Event e;

    event logTransfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        e = new Event();
    }

    function testEmitTransferEvent() public {
        //Test - 1
        //1. First identify the fields to check.
        vm.expectEmit(true, true, false, true);

        //2. Create the expected event.
        emit logTransfer(address(this), address(123), 456);

        //3. Call the contract to emit the actual event. 
        e.transfer(address(this), address(123), 456);


        //Test - 2 
        //1. First identify the fields to check.
        vm.expectEmit(true, false, false, false);
        //2. Create the expected event.
        emit logTransfer(address(this), address(123), 456);
        //3. Call the contract to emit the actual event. 
        e.transfer(address(this), address(456), 999);        

    }

    function testEmitTransferManyEvent() public {

        address[] memory to = new address[](2);
        to[0] = address(123);
        to[1] = address(456);

        uint256[] memory amount = new uint256[](2);
        amount[0] = 777;
        amount[1] = 888;

        //1. First identify the fields to check.
        vm.expectEmit(true, true, false, true);

        //2. Create the expected event.
        for(uint i; i < to.length; i++){
            emit logTransfer(address(this), to[i], amount[i]);
        }
        //3. Call the contract to emit the actual event.      
        e.transferMany(address(this), to, amount); 

    }
}