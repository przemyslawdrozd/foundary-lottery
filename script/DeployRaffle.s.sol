// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "./Interactions.s.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        (
            uint256 enterenceFee,
            uint256 interval,
            address vrfCoordinator,
            bytes32 gasLane,
            uint64 subId,
            uint32 callbackGasLimit,
            address link
        ) = helperConfig.activeNetworkConfig();

        if (subId == 0) {
            CreateSubscription createSub = new CreateSubscription();
            subId = createSub.createSubscription(vrfCoordinator);

            FundSubscription fundSub = new FundSubscription();
            fundSub.fundSub(vrfCoordinator, subId, link);
        }

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

        AddConsumer addConsumer = new AddConsumer();
        addConsumer.addConsumer(address(raffle), vrfCoordinator, subId);

        return (raffle, helperConfig);
    }
}
