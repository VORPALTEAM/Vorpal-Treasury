// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.15;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

import "./ITreasury.sol";

/// @title Treasury contract
/// @notice Stores and receives Vorpal tokens for future distribution

contract Treasury is ITreasury, AccessControl {
    using SafeERC20 for IERC20;

    IERC20 public vorpal;
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    // Address is equal to zero
    error ZeroAddress();

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /// @notice Sets up Vorpal token
    function setVorpal(address _vorpal) external {
        if(_vorpal == address(0)){
            revert ZeroAddress();
        }
        vorpal = IERC20(_vorpal);
    }  

    /// @notice Transfers tokens to an address
    function transfer(address to, uint256 value) external returns (bool) {
        vorpal.safeTransfer(to, value);
        return true;
    }

    /// @notice Returns Vorpal balance
    function getBalance() external view returns (uint256) {
        return vorpal.balanceOf(address(this));
    }

    ///@notice Grants `Operator` role to an account
    function grantOperatorRole(address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(OPERATOR_ROLE, account);
    } 
}
