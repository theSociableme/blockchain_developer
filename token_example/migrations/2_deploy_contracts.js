//const { default: getWeb3 } = require("../../node_project/client/src/getWeb3");

const SimpleStorage = artifacts.require("SimpleStorage");
const TutorialToken = artifacts.require("TutorialToken");
const ComplexStorage = artifacts.require("ComplexStorage");
const KycContract = artifacts.require("KycContract");
const MyTokenSale = artifacts.require("MyTokenSale");

module.exports = async function(deployer) {
  let addr = await web3.eth.getAccounts();
  await deployer.deploy(SimpleStorage);
  await deployer.deploy(TutorialToken);
  await deployer.deploy(ComplexStorage);
  await deployer.deploy(KycContract);
  await deployer.deploy(MyTokenSale, 1, addr[0], TutorialToken.address, KycContract.address);

};
