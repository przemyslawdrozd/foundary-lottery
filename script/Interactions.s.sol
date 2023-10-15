// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";

contract CreateSubscription is Script {
    function createSubUsingConfig() public returns (uint64) {
        HelperConfig helperConfig = new HelperConfig();
        (, , address vrfCoordinator, , , ) = helperConfig.activeNetworkConfig();
        return createSubscriptions(vrfCoordinator);
    }

    function createSubscriptions(
        address vrfCoordinator
    ) public returns (uint64) {
        console.log("Creating subscription on chainId: ", block.chainid);

        vm.startBroadcast();
        uint64 subId = VRFCoordinatorV2Mock(vrfCoordinator)
            .createSubscription();
        vm.stopBroadcast();

        console.log("Your sub id is: ", subId);
        console.log("Please update subId in HelperConfig.s.sol");
        return subId;
    }

    function run() external returns (uint256) {
        return createSubUsingConfig();
    }
}
