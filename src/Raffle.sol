// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

/**
 * @title A sampleRaffle Contract
 * @author Przemo
 * @notice Create a sample raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {
    error Raffle__NotEnoughtEthSent();

    uint16 private constant REQ_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    // @dev Duration of the lottery in seconds
    uint256 private immutable i_interval;
    uint256 private immutable i_enterenceFee;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subId;
    uint32 private immutable i_callbackGasLimit;

    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    /** Events */
    event EnteredRaffle(address indexed player);

    constructor(
        uint256 enterenceFee,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLane,
        uint64 subId,
        uint32 callbackGasLimit
    ) {
        i_enterenceFee = enterenceFee;
        i_interval = interval;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_gasLane = gasLane;
        i_subId = subId;
        i_callbackGasLimit = callbackGasLimit;
        s_lastTimeStamp - block.timestamp;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_enterenceFee, "Not enough ETH sent!");
        if (msg.value < i_enterenceFee) {
            revert Raffle__NotEnoughtEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {
        // 1. Get random number
        // 2. Use the random number to pcik a player
        // 3. Be autimatically called

        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }

        // Will revert if subscription is not set and funded.
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, // gas lane
            i_subId,
            REQ_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
    }

    /** Getter Function */
    function getEnteranceFee() external view returns (uint256) {
        return i_enterenceFee;
    }
}
