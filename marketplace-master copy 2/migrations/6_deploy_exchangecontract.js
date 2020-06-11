const ExchangeContract = artifacts.require("ExchangeContract");

module.exports = function(deployer) {
  deployer.deploy(ExchangeContract,"0xc15215dB68620229163fb5E7770848126adE55D6", "0xc15215dB68620229163fb5E7770848126adE55D6","0xc15215dB68620229163fb5E7770848126adE55D6","0xc7748556da9a1CD69f7f6B542662A856AbEf07d8");
};
