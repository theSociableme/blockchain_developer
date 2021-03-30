// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.6.0;

import "./Owned.sol";

contract InheritanceModifierExample is Owned{

    mapping(address => uint) public tokenBalance;
    
    uint tokenPrice = 1 ether;

    function getOwner() public view returns(address){
        return owner;    
    }
    
    function createNewToken() public onlyOwner{
        tokenBalance[owner]++;
    }
    
    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }
    
    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        
    }    

}