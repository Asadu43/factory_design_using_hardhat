// //SPDX-License-Identifier: Unlicense
// pragma solidity >=0.6.0 <0.9.0;
// import "hardhat/console.sol";

// contract OwnersRegistry {
//     address[] private erc20TokenOwners;
//     address[] private nftTokenOwners;

//     mapping(address=> mapping(address=> uint256)) tokenOwners;

//     function setERC20TokenOwner(address _contractAddress, address _owenerAddress) internal {

//         console.log("Token  Address",_contractAddress);
//         console.log("Token  Address",_owenerAddress);
//         erc20TokenOwners.push();

//         uint256 index = erc20TokenOwners.length -1;

//         erc20TokenOwners[index] = _contractAddress;
//         tokenOwners[_contractAddress][_owenerAddress] = index;
//     }

//     function setNFTTokenOwner(address _contractAddress, address _owenerAddress) internal {
//         nftTokenOwners.push();
//         uint256 index = nftTokenOwners.length -1;

//         nftTokenOwners[index] = _contractAddress;
//         tokenOwners[_contractAddress][_owenerAddress] = index;
//     }


//     function getERC20TokenOwner(address _contractAddress, address _owenerAddress) internal view returns(address){
//         uint256 index = tokenOwners[_contractAddress][_owenerAddress];
//         console.log(erc20TokenOwners[index]);
//         return erc20TokenOwners[index];
//     }

//     function getNFTTokenOwner(address _contractAddress, address _owenerAddress) internal view returns(address){
//         uint256 index = tokenOwners[_contractAddress][_owenerAddress];

//         console.log(nftTokenOwners[index]);
//         return nftTokenOwners[index];
//     }
// }