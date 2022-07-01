// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IFactory.sol";

contract AsadTokenERC20 is ERC20, Pausable, Ownable {

    IFactory iFactory;

    constructor(address _iFactory) ERC20("AsadTokenERC20", "ASD") {
        iFactory = IFactory(_iFactory); 
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