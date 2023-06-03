//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

contract TestWallet is Test {

Wallet wallet;
    function setUp() public {
        wallet = new Wallet();
    }

    function _transfer(uint256 amount) public {
        (bool ok, ) = address(wallet).call{value : amount}("");
        require(ok, "Transfer Failed");
    }

    function testTransfer() public {

        uint256 bal = address(wallet).balance;
        // Set the balance of a contract address
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        deal(address(1), 10);
        assertEq(address(1).balance, 10);

        // Set the balance of a contract and transfer Eth to another contract
        deal(address(1), 123);
        _transfer(123);

        // Set the balance and change the msg.sender
        deal(address(1), 456);
        vm.prank(address(1));
        _transfer(456);

        // Use the hoax to do the same transaction as above
        hoax(address(1), 789);
        _transfer(789);

        assertEq(address(wallet).balance, bal + 123 + 456 + 789);
    }
    function testEthThisContract() public view {
        console.log("Eth Amount:", address(this).balance);
    }

}