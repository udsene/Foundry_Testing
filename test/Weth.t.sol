//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "../src/IWeth.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract TestWethFork is Test {

    IWETH weth;
    function setUp() public {
        weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testDeposit() public {

        uint256 beforeBal = weth.balanceOf(address(this));
        console.log("Balance Before:", beforeBal);

        weth.deposit{value : 100}();

        uint256 afterBal = weth.balanceOf(address(this));
        console.log("Balance After:", afterBal);

        assertEq(afterBal, beforeBal + 100, "Deposit Error");
    }


}