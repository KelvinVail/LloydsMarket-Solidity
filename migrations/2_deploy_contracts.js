var mer = artifacts.require("./MarketEntityRegister.sol");
var bank = artifacts.require("./Bank.sol");

module.exports = function(deployer) {
  deployer.deploy(mer);
  deployer.deploy(bank);
};
