// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./IFactory.sol";
import "hardhat/console.sol";

contract AsadTokenERC20 is ERC20Upgradeable, PausableUpgradeable, OwnableUpgradeable {

    IFactory iFactory;
        function initialize(
        address _factoryAddress,
        address _recipient
    ) public initializer {
        iFactory = IFactory(_factoryAddress);
        __ERC20_init("AsadTokenERC20", "ASD");
        _transferOwnership(_recipient);
    }
        modifier PausedAll(){
        require(iFactory.getPasued() == false,"Pasued Contract Address");
        _;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner PausedAll {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}