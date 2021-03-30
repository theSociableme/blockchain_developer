// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.1;

import "./Allowance.sol";

contract SharedWallet is Allowance{

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function renounceOwnership() public override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }
    
    function withdrawFunds(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(address(this).balance >= _amount , "You can't overdraft");
        if(!isOwner()){
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);

    }
    
    receive() external payable{
        emit MoneyReceived(msg.sender, msg.value);
    }
}