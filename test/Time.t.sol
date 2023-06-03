//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract testAuction is Test {
    uint256 public startAt;
    Auction private auction;

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidStartTime() public {
        vm.expectRevert("revert bid");
        auction.bid();
    }

    function testBidSuccess() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidEndTime() public {
        vm.warp(startAt + 2 days);
        vm.expectRevert("revert bid");
        auction.bid();
    }

    function testEnd() public {
        vm.warp(startAt + 3 days);
        auction.end();
    }

    function testSkip() public {
        uint256 t = block.timestamp;
        //console.logInt(t);
        skip(100);
        assertEq(block.timestamp, t + 100, "Skip function does not work");

        rewind(10);
        assertEq(block.timestamp, t + 100 - 10, "Rewind function does not work");
    }

/*     function testRewind() public {
        uint256 t = block.timestamp;
        rewind(10);
        assertEq(block.timestamp, t - 10, "Rewind function does not work");
    } */

    function setBlockNumber() public {
        //uint256 b = block.number;
        vm.roll(999);
        assertEq(block.number, 999, "Invalid Blcok Number");
    }

}