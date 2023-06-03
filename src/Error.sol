// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract Error {

    error customRevert();

    function authorize() public view {
        require(false, "error message");
    }

    function customAuthorize() public view {
        revert customRevert();
    }
}