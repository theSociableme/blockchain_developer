// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.6.0;

contract DebuggerExample {
    uint public myUint;
    
    function setMeyUint(uint _myUint) public {
        myUint = _myUint;
    }
}