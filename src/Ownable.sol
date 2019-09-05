pragma solidity ^0.5.11;

contract Ownable {
    
    address public owner;
    
    constructor(address contractOwner) public {
        owner = contractOwner;
    }

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    function changeOwner(address _owner) onlyOwner public {
        owner = _owner;
    }
}