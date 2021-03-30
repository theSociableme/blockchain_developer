// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";


contract Allowance is Ownable {
    
    event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);
    
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    mapping(address => uint) public allowanceBalance;
    
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowanceBalance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }
    
    function setAllowance(address _for, uint _amount) public onlyOwner {
        emit AllowanceChanged(_for, msg.sender, allowanceBalance[_for], _amount);
        allowanceBalance[_for] = _amount;
    }
    
    function addToAllowance(address _for, uint _amount) public onlyOwner {
        emit AllowanceChanged(_for, msg.sender, allowanceBalance[_for], _amount);
        allowanceBalance[_for] += _amount;
    }
    
    function subtractFromAllowance(address _for, uint _amount) public onlyOwner {
        reduceAllowance(_for, _amount);
    }
    
    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender, allowanceBalance[_who], _amount);
        allowanceBalance[_who] -= _amount;
    }
}