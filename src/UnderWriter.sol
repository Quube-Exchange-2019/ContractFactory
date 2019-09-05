pragma solidity ^0.5.11;

import "./QuubeAccreditedList.sol";



contract Underwriter is QuubeAccreditedList
{
    
     mapping(address => bool) public SignedContracts;

    
     function SignContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=true;
     }
     
     function RegisterContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=false;
     }
     
     function UnSignContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=false;
         
     }
}