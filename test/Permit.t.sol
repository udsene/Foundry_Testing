//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Permit} from "../src/Permit.sol";
import "../src/ERC20Permit.sol";

contract TestPermit is Test {

    Permit permit;
    ERC20Permit token;
    address sender;
    address reciever;

    uint256 public constant AMOUNT = 100;
    uint256 public constant FEE = 10;
    uint256 public constant PERMIT_PRIVATE_KEY = 123;

    function setUp() public {

        sender = vm.addr(PERMIT_PRIVATE_KEY);
        reciever = address(2);

        permit = new Permit();
        token = new ERC20Permit("Test", "Test", 18);

        token.mint(sender, AMOUNT + FEE);

    }

    function testPermit() public {

        uint256 nonce = token.nonces(sender);
        uint256 deadline = block.timestamp + 60; 

        bytes32 hashMessageResult = hashMessage(sender, address(permit), AMOUNT + FEE, nonce, deadline);
//        bytes32 hashMessageResult = hashMessage(nonce, deadline);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(PERMIT_PRIVATE_KEY, hashMessageResult);

        permit.send(address(token), sender, reciever, AMOUNT, FEE, deadline, v, r, s);

        assertEq(token.balanceOf(sender), 0, "Error in the sender balance");
        assertEq(token.balanceOf(reciever), 100, "Error in the reciever balance");
        assertEq(token.balanceOf(address(this)), 10, "Error in this contract balance");

    }

    function testlogBalance() public {
        console.log("The balance of sender :", token.balanceOf(sender));
        assertEq(token.balanceOf(sender), 110);
    }

    function hashMessage(address owner, address spender, uint256 value, uint256 nonce, uint256 deadline) private view returns(bytes32) {
        return  keccak256(
                    abi.encodePacked(
                        "\x19\x01",
                        token.DOMAIN_SEPARATOR(),
                        keccak256(
                            abi.encode(
                                keccak256(
                                    "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                                ),
                                owner,
                                spender,
                                value,
                                nonce,
                                deadline
                            )
                        )
                    )
                );
    }

/*     function hashMessage(uint256 nonce, uint256 deadline) private view returns(bytes32) {
        return  keccak256(
                    abi.encodePacked(
                        "\x19\x01",
                        token.DOMAIN_SEPARATOR(),
                        keccak256(
                            abi.encode(
                                keccak256(
                                    "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                                ),
                                sender,
                                address(permit),
                                AMOUNT + FEE,
                                nonce,
                                deadline
                            )
                        )
                    )
                );
    }    */ 
}

// Sender transaction to permit should approve this contract to spend sender's tokens on his behalf
// Sender should send the tokens to reciever
// Sender fee should be sent to this contract
// Sender balance should be reduced