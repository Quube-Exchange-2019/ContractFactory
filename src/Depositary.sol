pragma solidity ^0.5.11;

import "./Ownable.sol";
import "./QuubeAccreditedList.sol";



contract Depositary is  QuubeAccreditedList
{
     struct HolderDescription
     {
         string FullName;
         address Address;
     }
     mapping(address => bool) public SignedContracts;
     mapping(address => mapping(address =>uint)) public Holders;
     mapping(address => HolderDescription) public holderDescriptions;
     
     function RegisterContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=false;
     }

     function SignContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=true;
     }

     function UnSignContract(address contractAddress) public onlyWhitelistAdmin {
         SignedContracts[contractAddress]=false;
         
     }
     
     function SetHolderValue(address contractAddress, address holderAddress,uint count) public onlyWhitelistAdmin  {
        require(contractAddress!=address(0), "Contract address can not be empty");
        require(holderAddress!=address(0), "Holder address can not be empty");
        Holders[contractAddress][holderAddress]=count;
     }
     
     function GetHolderValue(address contractAddress, address holderAddress,uint count) public onlyWhitelisted {
        require(contractAddress!=address(0), "Contract address can not be empty");
        require(holderAddress!=address(0), "Holder address can not be empty");
        Holders[contractAddress][holderAddress]=count;
     }
     
     function SetHolderDescription( address holderAddress, string memory fullName) public onlyWhitelistAdmin  {
        require(holderAddress!=address(0), "Holder address can not be empty");
        HolderDescription memory newholder;
        newholder.Address = holderAddress;
        newholder.FullName=fullName;
        holderDescriptions[holderAddress]=newholder;
     }
     
     function GetHolderDescription(address holderAddress) public view onlyWhitelisted returns(string memory ,  address) {
        require(holderAddress!=address(0), "Holder address can not be empty");
        HolderDescription memory holder=holderDescriptions[holderAddress];
        return (holder.FullName,holder.Address);
     }
     
}