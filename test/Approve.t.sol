// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Test.sol";
import "../src/SecureMe.sol";

contract ApproveTest is Test {
    address public constant USDTAddr =
        0xdAC17F958D2ee523a2206206994597C13D831ec7;
    uint256 mainnetFork;
    ERC20 USDT = ERC20(USDTAddr);
    address user = 0x0162Cd2BA40E23378Bf0FD41f919E1be075f025F;
    SecureMe instance;

    function setUp() public {
        // Create the fork
        mainnetFork = vm.createFork(vm.envString("MAINNET_RPC_URL"));
        // Instantiate SecureMe
        instance = new SecureMe(100 ether, USDT);
        // Boostrap test contract w/ ETH
        deal(address(this), 100 ether);
        deal(address(user), 100 ether);
    }

    function test_approve() public {
        address actualUser = address(0x0162Cd2BA40E23378Bf0FD41f919E1be075f025F);
        vm.selectFork(mainnetFork);
        vm.prank(actualUser);
        // Allowance to instance
        // This reverts. But calls to `view` functions succeed
        IERC20(USDTAddr).transfer(address(instance), 50);
    }
}
