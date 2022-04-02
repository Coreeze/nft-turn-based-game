const main = async () => {
  const gameContractFactory = await hre.ethers.getContractFactory("MyEpicGame");
  const gameContract = await gameContractFactory.deploy(
    ["Aang", "Leo", "Pikachu"],
    [
      "https://i.imgur.com/xVu4vFL.png",
      "https://i.imgur.com/pKd5Sdk.png",
      "https://i.imgur.com/u7T87A6.png",
    ],
    [100, 200, 300],
    [100, 50, 25],
    // boss data
    "Elon Musk",
    "https://i.imgur.com/AksR0tt.png",
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
