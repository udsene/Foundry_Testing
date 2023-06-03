// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CounterAdvanced.sol";

contract CounterAdvancedTest is Test {
    CounterAdvanced public counterAdvanced;

    function setUp() public {
        counterAdvanced = new CounterAdvanced();
    }

    function testInc() public {
        counterAdvanced.inc();
        uint256 counter = counterAdvanced.getCounter();
        assertEq(counter, 1);
    }

    function testFailDec() public {
        counterAdvanced.dec();
        // uint256 counter = counterAdvanced.getCounter();        
        // assertEq(counter, 1);
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        counterAdvanced.dec();
    }

    function testDec() public {
        counterAdvanced.inc();
        counterAdvanced.inc();
        counterAdvanced.inc();

        counterAdvanced.dec();

        assertEq(counterAdvanced.counter(), 2);
    }
}