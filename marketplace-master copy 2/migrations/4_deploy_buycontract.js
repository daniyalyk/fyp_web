const BuyContract = artifacts.require("BuyContract");

module.exports = function(deployer) {
  deployer.deploy(BuyContract,"0xc15215dB68620229163fb5E7770848126adE55D6", "0xc15215dB68620229163fb5E7770848126adE55D6", "0xc15215dB68620229163fb5E7770848126adE55D6", "0xc15215dB68620229163fb5E7770848126adE55D6");
};
