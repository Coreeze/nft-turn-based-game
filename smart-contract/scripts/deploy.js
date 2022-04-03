const main = async () => {
  const gameContractFactory = await hre.ethers.getContractFactory("MyEpicGame");
  const gameContract = await gameContractFactory.deploy(
    ["Aang", "Leo", "Pikachu"],
    [
      "bafybeihj3g7wzzcgy7uxxatcp5nkehij5yp3rse6hsmyh6ddw6x2jvyexm.ipfs.nftstorage.link/",
      "bafybeibi5vcfcjrdndcmjcwxotdobhdmsitf4zsegxwsdir5tuoydvn6ca.ipfs.nftstorage.link/",
      "bafybeiet7aw64wfx5hiomhj2gtnp47p4om6xcd2m74p2uehelj4lleyfkm.ipfs.nftstorage.link/",
    ],
    [100, 200, 300],
    [100, 50, 25],
    // boss data
    "Elon Musk",
    "bafybeids36qnyqncelzh743bcpywhqbvuvpoqewd6yhoz2k4mfuqfej6rm.ipfs.nftstorage.link/",
    10000,
    50
  );
  await gameContract.deployed();
  console.log("Contract deployed to:", gameContract.address);

  // We only have three characters.
  // an NFT w/ the character at index 2 of our array.
  //   let txn;
  //   txn = await gameContract.mintCharacterNFT(2);
  //   await txn.wait();

  //   txn = await gameContract.attackBoss();
  //   await txn.wait();

  //   txn = await gameContract.attackBoss();
  //   await txn.wait();

  //   console.log("Done!");

  //   let returnedTokenURI = await gameContract.tokenURI(0);
  //   console.log("Token URI:", returnedTokenURI);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
