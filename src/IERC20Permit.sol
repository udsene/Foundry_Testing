//SPDX-License-Identifer : MIT
pragma solidity ^0.8.0;

interface IERC20Permit{

    function transferFrom(address from, address to, uint256 amount) external;
    function permit(address owner, address spender, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;

}