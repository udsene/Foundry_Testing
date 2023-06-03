//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Error} from "../src/Error.sol";

contract TestError is Test {

Error public error;

    function setUp() public {
        error = new Error();
    }

    function testFailRevert() public {
        error.authorize();
    }

    function testRevert() public {
        vm.expectRevert();
        error.authorize();
    }

    function testRevertRequireMessage() public {
        vm.expectRevert(bytes("error message"));
        error.authorize();
    }    

    function testRevertCustomError() public {
        vm.expectRevert(Error.customRevert.selector);
        error.customAuthorize();
    }

    function testAssertLabels() public {

        assertEq(uint(1), uint(1), "Label 1");
        assertEq(uint(1), uint(1), "Label 2");
        assertEq(uint(1), uint(1), "Label 3");
        assertEq(uint(1), uint(2), "Label 4");
        assertEq(uint(1), uint(1), "Label 5");

    }

}