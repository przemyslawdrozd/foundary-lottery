// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/**
 * @title A sampleRaffle Contract
 * @author Przemo
 * @notice Create a sample raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {
    error Raffle__NotEnoughtEthSent();

    uint256 private immutable i_enterenceFee;

    address payable[] private s_players;

    /** Events */
    event EnteredRaffle(address indexed player);

    constructor(uint256 enterenceFee) {
        i_enterenceFee = enterenceFee;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_enterenceFee, "Not enough ETH sent!");
        if (msg.value < i_enterenceFee) {
            revert Raffle__NotEnoughtEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public {}

    /** Getter Function */
    function getEnteranceFee() external view returns (uint256) {
        return i_enterenceFee;
    }
}
