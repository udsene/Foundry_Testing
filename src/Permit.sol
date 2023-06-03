//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "./IERC20Permit.sol";

contract Permit{


    function send(
        address token,
        address sender,
        address reciever,
        uint256 amount,
        uint256 fee,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        //  Permit the address(this) (spender) to pull the tokens from the sender
        IERC20Permit(token).permit(sender, address(this), amount+fee, deadline, v, r, s);
        // Transfer the token amount to the reciever
        IERC20Permit(token).transferFrom(sender, reciever, amount);
        // Transfer the token fee to the msg.sender
        IERC20Permit(token).transferFrom(sender, msg.sender, fee);
    }


}