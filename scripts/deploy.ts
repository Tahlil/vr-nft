import { ethers } from "hardhat";

async function main() {

  const SpaceNFT = await ethers.getContractFactory("SpaceToken");
  const spaceNFT = await SpaceNFT.deploy();

  await spaceNFT.deployed();

  console.log("Contract deployed to:", spaceNFT.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
