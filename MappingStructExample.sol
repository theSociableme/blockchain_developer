// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.1;

contract MappingStructExample {
    
    struct Payment {
        uint amount;
        uint timestamp;
    }
    
    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    mapping(address => Balance) public balancedReceived;
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        balancedReceived[msg.sender].totalBalance += msg.value;
        
        Payment memory payment = Payment(msg.value, block.timestamp);
        
        balancedReceived[msg.sender].payments[balancedReceived[msg.sender].numPayments] = payment;
        balancedReceived[msg.sender].numPayments++;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(balancedReceived[msg.sender].totalBalance >= _amount, "You dont have enough");
        balancedReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
    
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balancedReceived[msg.sender].totalBalance;
        balancedReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }
}