// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 < 0.9.0;

import "./AsadTokenERC721.sol";
import "./AsadTokenERC20.sol";
import "hardhat/console.sol";
import "./IFactory.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Factory is Ownable,IFactory {
    AsadTokenERC20[] public token20;
    AsadTokenERC721[] public token721;

    bool public paused;

    event Erc20Event(address token, address ownerAddress);
    event Erc721Event(address token, address ownerAddress);
    event Erc20PauseEvent(address token);
    event Erc721PauseEvent(address token);

    function getTokens()
        external
        view
        returns (AsadTokenERC20[] memory _tokens)
    {
        console.log("Token Length", token20.length);
        return token20;
    }

    function getERC721Tokens()
        external
        view
        returns (AsadTokenERC721[] memory _tokens)
    {
        console.log("Token Length", token721.length);
        return token721;
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner(), "You are not the owner");
        paused = _paused;
    }

    function getPasued() public override returns(bool){
      return paused;
    }

    function removePauseCapability() public {
        require(msg.sender == owner(), "You are not the owner");
        paused = false;
    }

    function createChildERC20() public {
        require(paused == false, "Can't Create Contact");
        AsadTokenERC20 child = new AsadTokenERC20(address(this),msg.sender);
        console.log("ChildAddress: ", address(child));
        token20.push(child);
        // setERC20TokenOwner(address(child), msg.sender);
        emit Erc20Event(address(child),msg.sender);
    }

    function createChildERC721() public {
        require(paused == false, "Can't Create Contact");
        AsadTokenERC721 child = new AsadTokenERC721(address(this));
        token721.push(child);
        // setNFTTokenOwner(address(child), msg.sender);
       emit Erc721Event(address(child),msg.sender);
    }

    function pauseERC20(address tokenAddress) public onlyOwner {
        AsadTokenERC20 token = AsadTokenERC20(tokenAddress);
        token.pause();
        emit Erc20PauseEvent(tokenAddress);
    }

    function pauseERC721(address tokenAddress) public onlyOwner {
        AsadTokenERC721 token = AsadTokenERC721(tokenAddress);
        token.pause();
        emit Erc721PauseEvent(tokenAddress);
    }
}
