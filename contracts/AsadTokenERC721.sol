// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IFactory.sol";



contract AsadTokenERC721 is ERC721, Pausable, Ownable {
    IFactory ifactory;
    constructor(address _iFactory) ERC721("AsadTokenERC721", "ASD") {
        
        ifactory = IFactory(_iFactory);
    }

    function _baseURI() internal pure  returns (string memory) {
        return "https://github.com/optionality/clone-factory";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}