pragma solidity ^0.5.11;


import "./QuubeAccreditedList.sol";



contract QuubeSigner is QuubeAccreditedList
{
    
     mapping(address => bool) public SignedContracts;

     
     function RegisterContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=false;
     }
     
     function SignContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=true;
     }
     
     
     function UnSignContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=false;
         
     }
}