const Migrations = artifacts.require("Migrations");
const Blake2b = artifacts.require("Blake2b");
const Altbn128 = artifacts.require("Altbn128");
const PrecompiledContract = artifacts.require("PrecompiledContract");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Blake2b);
  deployer.deploy(Altbn128);
  deployer.deploy(PrecompiledContract);
};
