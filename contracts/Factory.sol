// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AsadTokenERC721.sol";
import "./AsadTokenERC20.sol";
import "hardhat/console.sol";
import "./IFactory.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";

contract Factory is Ownable,IFactory {
    AsadTokenERC20[] public token20;
    AsadTokenERC721[] public token721;

    address public superNftTokenAddress;
    address public superERC20TokenAddress;

    bool public paused;

    event Erc20Event(address token, address ownerAddress);
    event Erc721Event(address token, address ownerAddress);
    event Erc20PauseEvent(address token);
    event Erc721PauseEvent(address token);


    constructor(address _erc20address,address _nftaddress) {
        superNftTokenAddress = _nftaddress;
        superERC20TokenAddress = _erc20address;
    }


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
        address clonedTokenAddress = Clones.clone(superERC20TokenAddress);
        console.log(clonedTokenAddress);
        AsadTokenERC20 child =  AsadTokenERC20(clonedTokenAddress);
        console.log("admin: ", msg.sender);
        child.initialize(address(this), msg.sender);
        console.log("ChildAddress: ",address(child));
        token20.push(child);
        emit Erc20Event(address(child),msg.sender);
    }

    function createChildERC721() public {
        require(paused == false, "Can't Create Contact");
        address clonedTokenAddress = Clones.clone(superNftTokenAddress);
        AsadTokenERC721 child = AsadTokenERC721(clonedTokenAddress);
        child.initialize(address(this), msg.sender);
        token721.push(child);
        // setNFTTokenOwner(address(child), msg.sender);
       emit Erc721Event(address(child),msg.sender);
    }

    function pauseERC20(address tokenAddress) public  {
        AsadTokenERC20 token = AsadTokenERC20(tokenAddress);
        token.pause();
        emit Erc20PauseEvent(tokenAddress);
    }

    function pauseERC721(address tokenAddress) public  {
        AsadTokenERC721 token = AsadTokenERC721(tokenAddress);
        token.pause();
        emit Erc721PauseEvent(tokenAddress);
    }
}
