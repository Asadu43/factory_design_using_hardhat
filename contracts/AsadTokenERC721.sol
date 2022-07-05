// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./IFactory.sol";


contract AsadTokenERC721 is ERC721Upgradeable, PausableUpgradeable, OwnableUpgradeable {
    IFactory ifactory;


        function initialize(address _factoryAddress, address _recipient)
        public
        initializer
    {
        ifactory = IFactory(_factoryAddress);
        __ERC721_init("AsadTokenERC721", "ASD");
        _transferOwnership(_recipient);
    }
    // constructor(address _iFactory) ERC721("AsadTokenERC721", "ASD") {
        
    //     ifactory = IFactory(_iFactory);
    // }


    
    modifier PausedAll() {
        require(ifactory.getPasued() == false, "Pasued Contract Address");
        _;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://github.com/optionality/clone-factory";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner PausedAll {
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}

