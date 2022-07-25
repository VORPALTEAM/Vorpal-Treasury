pragma solidity 0.8.15; 
interface ITreasury {
    function transfer(address to, uint256 value) external returns (bool);
}