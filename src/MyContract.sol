// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Ownable} from "openzeppelin-contracts/contracts/Access/Ownable.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "forge-std/Test.sol";

contract MyContract is ERC20, Ownable {
    // Not relevant what this contract does

    ERC20 public USDT;
    constructor(uint256 initialSupply, ERC20 _USDT) ERC20("SecureMe", "SMTK") {
        _mint(msg.sender, initialSupply);
        USDT = _USDT;
    }

    /// @notice mints SMTK tokens to users. Callable only by the owner
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function deposit() external payable {
        require(msg.value > 0, "SecureMe: Cannot deposit 0 ETH");
        _mint(msg.sender, msg.value);
    }

    function depositUSDT(uint256 amount) external {
        console.log("Im here");

        require(amount != 0);
        // Transfer amount of USDT to this contract
        // msg.sender is the caller so this works
        // require(USDT.allowance(msg.sender, address(this)) >= amount, "You must approve the transfer of USDT first");
        // console.log("Im here");
        // USDT.transferFrom(msg.sender, address(this), amount);
        // Mint amount of tokens
        _mint(msg.sender, amount);

    }
}
