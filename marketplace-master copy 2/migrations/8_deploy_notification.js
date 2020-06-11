const Notification = artifacts.require("Notification");

module.exports = function(deployer) {
  deployer.deploy(Notification);
};
