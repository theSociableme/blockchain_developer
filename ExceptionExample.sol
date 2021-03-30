// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.1;

contract ExceptionExample {
    
    mapping(address => uint64) public balanceReceived;
    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "not enough funds");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}