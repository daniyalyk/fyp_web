const Commodity = artifacts.require("Commodity");

module.exports = function(deployer) {
  deployer.deploy(Commodity, "0xc15215dB68620229163fb5E7770848126adE55D6");
};
