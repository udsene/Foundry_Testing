//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract TestSignature is Test {

    function testSignature() public {
        // Create the private key
        uint256 privateKey = 123;

        //Get the public key
        address publicKey = vm.addr(privateKey);

        //hash the message
        bytes32 messageHash = keccak256("Secret Message");

        // Sign the messageHash
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        // Recover the address
        address signer = ecrecover(messageHash, v, r, s);

        require(signer != address(0), "ecrecover failed");

        // Check the signer is correctly recovered
        assertEq(signer, publicKey);

        // Create an invalid message which is not signed by the private key.
        bytes32 invalidMessageHash = keccak256("Invalid Message");

        // Use the signature of the previous message which was signed by the private key.
        signer = ecrecover(invalidMessageHash, v, r, s);

        // Assert if the two signer are the same
        assertTrue(signer != publicKey);
    }

}