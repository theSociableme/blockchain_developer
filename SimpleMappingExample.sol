// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.1;

contract SimpleMappingExample {
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }
    
    function toggleValue(uint _index) public {
        myMapping[_index] = !myMapping[_index];
    }
    
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
    
    function toggleMyAddress() public {
        myAddressMapping[msg.sender] = !myAddressMapping[msg.sender];
    }
}