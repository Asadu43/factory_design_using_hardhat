import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect, use } from "chai";
import { Contract, BigNumber, Signer } from "ethers";
import { parseEther } from "ethers/lib/utils";
import hre, { ethers } from "hardhat";
import { AsadTokenERC20__factory } from "../../typechain";

describe("Asad Factory", function async() {

  let signers: Signer[];

  let factoryContract: Contract;
  let owner:SignerWithAddress;
  let user:SignerWithAddress;
  let user2:SignerWithAddress;
  let user3:SignerWithAddress;


  let Factory:any;
  let f: Contract;

  before(async () => {
     [owner, user,user2,user3] = await ethers.getSigners();

    hre.tracer.nameTags[owner.address] = "ADMIN";
    hre.tracer.nameTags[user.address] = "USER1";
    hre.tracer.nameTags[user2.address] = "USER2";
     Factory = await ethers.getContractFactory("Factory");
    factoryContract = await Factory.deploy();
  });


  // it("Set Pause", async function () {
  //   await factoryContract.connect(owner).setPaused(true)
  // });

  it("Should Create ERC20", async function () {
    await factoryContract.connect(owner).createChildERC20()
    // await factoryContract.createChildERC20()
    // await factoryContract.createChildERC20()

    console.log(owner.address)
    console.log(user.address)
    console.log(user2.address)
    console.log(await factoryContract.callStatic.token20(0))

    

    console.log("Token 20 ength" ,await factoryContract.callStatic.getTokens())
    console.log("Token 20 ength" ,(await factoryContract.callStatic.getTokens()).length)
  });

  it("Should Create ERC721", async function () {
    await factoryContract.createChildERC721()
    await factoryContract.createChildERC721()
    await factoryContract.createChildERC721()
    console.log("Token 721 ength" ,await factoryContract.callStatic.getERC721Tokens())
    console.log("Token 721 ength" ,(await factoryContract.callStatic.getERC721Tokens()).length)

  });

  it("Should Not Pause ERC20", async function () {
    await expect(factoryContract.connect(user).pauseERC20(factoryContract.callStatic.token20(0))).to.be.revertedWith("Ownable: caller is not the owner")
  });

  // it("Should  Pause ERC20", async function () {
  //   await expect( factoryContract.connect(owner).pauseERC20(await factoryContract.callStatic.token20(0))).to.emit(factoryContract,'Erc20PauseEvent').withArgs(await factoryContract.callStatic.token20(0))
  // });

  it("Should Not Pause ERC721", async function () {
    await expect(factoryContract.connect(user).pauseERC721(factoryContract.callStatic.token721(0))).to.be.revertedWith("Ownable: caller is not the owner")
  });

  it("Should  Pause ERC721", async function () {
    await expect( factoryContract.connect(owner).pauseERC721(await factoryContract.callStatic.token721(0))).to.emit(factoryContract,'Erc721PauseEvent').withArgs(await factoryContract.callStatic.token721(0))
  });

  it("Set Pause", async function () {
    await factoryContract.connect(owner).setPaused(true)
  });

  it("Pause Not False", async function () {
     await expect(factoryContract.createChildERC20()).to.be.revertedWith("Can't Create Contact")
  });

  it("Can't Create Pause Not False", async function () {
     await expect(factoryContract.createChildERC721()).to.be.revertedWith("Can't Create Contact")
  });

    it("Set Pause  false", async function () {
    await factoryContract.connect(owner).removePauseCapability()
  });

  it(" Create Pause  False", async function () {
    // await factoryContract.connect(owner).createChildERC721()
    
      f = AsadTokenERC20__factory.connect(await factoryContract.callStatic.token20(0),owner)
      console.log(await f.address)
  });

  // it(" Create Pause  False", async function () {
  //   // console.log(factoryContract.functions);
  //    await factoryContract.connect(owner).createChildERC721()
  // });

  it("Set Pause", async function () {
    console.log(await factoryContract.callStatic.paused())
    await factoryContract.connect(owner).setPaused(true)
    console.log(await factoryContract.callStatic.paused())
  });

  it("ERC20 Token", async function () {
    console.log(f.functions)
    console.log(await f.callStatic.owner())
    console.log(await f.callStatic.name())
    console.log(await f.callStatic.symbol())
    await expect(await  f.callStatic.owner()).to.equal(owner.address)
    await expect(await  f.callStatic.name()).to.equal("AsadTokenERC20")
    await expect(await  f.callStatic.symbol()).to.equal("ASD")
    // await f.connect(owner).mint(owner.address,1000)
  })

  it("Pasued Contract Address", async function () {
    // console.log(f.functions)

    await expect(f.connect(owner).mint(owner.address,1000)).to.be.revertedWith("Pasued Contract Address")
    // await f.connect(owner).mint(owner.address,1000)
  })
  it("Set Pause False", async function () {
    console.log(await factoryContract.callStatic.paused())
    await factoryContract.connect(owner).setPaused(false)
    console.log(await factoryContract.callStatic.paused())
  }); 

  it("Mint", async function () {
    // console.log(f.functions)

    // await expect(f.connect(owner).mint(owner.address,1000)).to.be.revertedWith("Pasued Contract Address")
    await f.connect(owner).mint(owner.address,BigNumber.from("1000"))
    // console.log(await f.callStatic.balanceOf(owner.address))
  })

  
  it("BalanceOf ", async function () {
    // console.log(f.functions)

    // await expect(f.connect(owner).mint(owner.address,1000)).to.be.revertedWith("Pasued Contract Address")
    // await f.connect(owner).mint(owner.address,BigNumber.from("1000"))
    expect(await f.callStatic.balanceOf(owner.address)).to.be.equal(BigNumber.from("1000"))
  })

});
