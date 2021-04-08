const TutorialToken = artifacts.require("TutorialToken");
var chai = require("chai");
const BN = web3.utils.BN;
const chaiBN = require("chai-bn")(BN);
chai.use(chaiBN);

var chaiAsPromised = require("chai-as-promised");

chai.use(chaiAsPromised);

const expect = chai.expect;

contract("TutorialToken", async (accounts) => {

    const[deployerAccount, recipient, anotherAccount] = accounts;

    it("all tokens should be in my account", async () => {
        let instance = await TutorialToken.deployed();
        let totalSupply = await instance.totalSupply();
        //let balance = await instance.balanceOf(accounts[0]);
        expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply);
    })

    it("is possible to send tokens between accounts", async () => {
        const sendTokens = 1;
        let instance = await TutorialToken.deployed();
        let totalSupply = await instance.totalSupply();
        //let balance = await instance.balanceOf(accounts[0]);
        expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply);
        expect(instance.transfer(recipient, sendTokens)).to.eventually.be.fulfilled;
        expect(instance.balanceOf(deployerAccount)).to.eventually.be.a.bignumber.equal(totalSupply.sub(new BN(sendTokens)));
        expect(instance.balanceOf(recipient)).to.eventually.be.a.bignumber.equal(new BN(sendTokens));
    })



})