// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {Raffle} from "../../src/Raffle.sol";

contract RaffleTest is Test {
    Raffle raffle;

    address public PLAYER = makeAddr("player");

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        raffle = deployer.run();
    }
}
