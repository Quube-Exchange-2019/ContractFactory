pragma solidity ^0.5.11;

import "./Erc20WithRestrictedStartTime.sol";
import "./QuubeContractFactory.sol";

contract RestrictedByTimeFactory is QuubeContractFactory
{

     function createErc20Contract (address ownerAddress, string memory name,string memory contractSymbol, uint256 totalSupply, uint256 tradingStartTime) public returns (address) {
        require(QuubeVerifiedList( QuubeVerifiedListAddress).CheckAddress(msg.sender), "Whitelisted  only address can create contract");
        address newContract = address(new QuubeErc20WithRestrictedStartTime(ownerAddress,name,contractSymbol,totalSupply,tradingStartTime));
        PushToList(newContract,ownerAddress,name,contractSymbol,totalSupply);
        emit NewContractCreated(newContract,name,contractSymbol,totalSupply);
        return newContract;
    } 
    
    constructor (address ContractsList) QuubeContractFactory(ContractsList) public 
    {
    }
    

    
    
}