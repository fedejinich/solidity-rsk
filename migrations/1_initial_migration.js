const Migrations = artifacts.require("Migrations");
const Blake2b = artifacts.require("Blake2b");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Blake2b);
};
