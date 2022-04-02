require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.1",
  networks: {
    rinkeby: {
      url: "https://eth-rinkeby.alchemyapi.io/v2/fsz9fzlJBnJqRIHOMhu2FiScxIhC1unG",
      accounts: [
        "ea99116deab605a6c1701ec3d276150d602af290e80a8b3b6cd12c88dd7f7139",
      ],
    },
  },
};
