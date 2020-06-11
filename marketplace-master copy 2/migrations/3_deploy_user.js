const User = artifacts.require("User");

module.exports = function(deployer) {
  deployer.deploy(User, "0xc15215dB68620229163fb5E7770848126adE55D6","0xc15215dB68620229163fb5E7770848126adE55D6");
};