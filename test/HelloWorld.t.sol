// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HelloWorld.sol";

contract HellowWorldTest is Test {
    HelloWorld public helloWorld;

    function setUp() public {
        helloWorld = new HelloWorld();
    }

    function testGreet() public {
        string memory greet = helloWorld.greet();
        assertEq(greet, "Hello World!");
    }
}
