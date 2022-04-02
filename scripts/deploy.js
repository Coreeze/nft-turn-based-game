const main = async () => {
  const gameContractFactory = await hre.ethers.getContractFactory("MyEpicGame");
  const gameContract = await gameContractFactory.deploy(
    ["Leo", "Aang", "Pikachu"],
    [
      "https://i.imgur.com/pKd5Sdk.png",
      "https://i.imgur.com/xVu4vFL.png",
      "https://i.imgur.com/u7T87A6.png",
    ],
    [100, 200, 300],
    [100, 50, 25]
  );
  await gameContract.deployed();
  console.log("Contrat deployed at: ", gameContract.address);

  let txn;
  txn = await gameContract.mintCharacterNFT(0);
  await txn.wait();
  console.log("Minted character 0");

  txn = await gameContract.mintCharacterNFT(1);
  await txn.wait();
  console.log("Minted character 1");

  txn = await gameContract.mintCharacterNFT(2);
  await txn.wait();
  console.log("Minted character 2");

  txn = await gameContract.mintCharacterNFT(3);
  await txn.wait();
  console.log("Minted character 3");

  console.log("All characters minted!");
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
