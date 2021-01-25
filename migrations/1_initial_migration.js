const Migrations = artifacts.require("Migrations");
const Blake2b = artifacts.require("Blake2b");
const Altbn128 = artifacts.require("Altbn128");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Blake2b);
  deployer.deploy(Altbn128);
};
