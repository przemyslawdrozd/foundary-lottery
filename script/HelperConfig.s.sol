// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    uint32 public constant SEPOLIA_CHAIN_ID = 11155111;

    struct NetworkConfig {
        uint256 enterenceFee;
        uint256 interval;
        address vrfCoordinator;
        bytes32 gasLane;
        uint64 subId;
        uint32 callbackGasLimit;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == SEPOLIA_CHAIN_ID) {
            activeNetworkConfig = handleSepoliaEthConfig();
        } else {
            activeNetworkConfig = handleAnvilEthConfig();
        }
    }

    function handleAnvilEthConfig() public view returns (NetworkConfig memory) {
        if (activeNetworkConfig.vrfCoordinator != address(0)) {
            return activeNetworkConfig;
        }

        return
            NetworkConfig({
                enterenceFee: 0.01 ether,
                interval: 30,
                vrfCoordinator: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625,
                gasLane: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
                subId: 0, // Update this with our subId!
                callbackGasLimit: 500000
            });
    }

    function handleSepoliaEthConfig()
        public
        view
        returns (NetworkConfig memory)
    {
        return
            NetworkConfig({
                enterenceFee: 0.01 ether,
                interval: 30,
                vrfCoordinator: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625,
                gasLane: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
                subId: 0, // Update this with our subId!
                callbackGasLimit: 500000
            });
    }
}
