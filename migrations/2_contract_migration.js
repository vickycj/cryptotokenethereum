const token = artifacts.require("./VickyCoinToken.sol");

module.exports = function(deployer) {
    deployer.deploy(token);
};