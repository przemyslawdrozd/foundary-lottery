// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle) {
        HelperConfig helperConfig = new HelperConfig();
        (
            uint256 enterenceFee,
            uint256 interval,
            address vrfCoordinator,
            bytes32 gasLane,
            uint64 subId,
            uint32 callbackGasLimit
        ) = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        Raffle raffle = new Raffle(
            enterenceFee,
            interval,
            vrfCoordinator,
            gasLane,
            subId,
            callbackGasLimit
        );
        vm.stopBroadcast();

        return raffle;
    }
}
