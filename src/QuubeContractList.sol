pragma solidity ^0.5.11;

import "./Ownable.sol";
import "./QuubeVerifiedList.sol";
import "./Depositary.sol";
import "./Underwriter.sol";
import "./QuubeSigner.sol";




contract QuubeContractList is Ownable
{
    struct ContractDefinition {
        uint contractId;
        address contractAddress;
        address ownerAddress;
        string name; 
        string symbol;
        uint totalSupply;
        bool deployed;
        bool deleted;
        bool DepositarySigned;
        bool UnderwriterSigned;
        bool QuubeSigned;
        uint RegisterTime;
    }
    
    uint public ContractsCount;
    mapping(address => ContractDefinition) public Contracts;
    
    constructor () Ownable(msg.sender) public{}
    
    function AddContract (address contractAddress, address ownerAddress, string memory name,string memory contractSymbol, uint256 totalSupply)  public returns(bool) {
        require(QuubeVerifiedList(QuubeVerifiedListAddress).CheckAddress(msg.sender), "Whitelisted  only address can add contract");
        ContractsCount++;
        Contracts[contractAddress].contractId=ContractsCount;
        Contracts[contractAddress].contractAddress=contractAddress;
        Contracts[contractAddress].ownerAddress=ownerAddress;
        Contracts[contractAddress].name=name;
        Contracts[contractAddress].symbol=contractSymbol;
        Contracts[contractAddress].totalSupply=totalSupply;
        Contracts[contractAddress].deployed=true;
        Contracts[contractAddress].DepositarySigned=false;
        Contracts[contractAddress].UnderwriterSigned=false;
        Contracts[contractAddress].QuubeSigned=false;
        Contracts[contractAddress].RegisterTime=now;
        return true;
    }
    
     function RemoveContract (address contractAddress) public {
        require(QuubeVerifiedList(msg.sender).CheckAddress(msg.sender), "Whitelisted  only address can remove contract");
        Contracts[contractAddress].deleted=true; 
     }
     
     address DepositaryAddress;
     function   SetDepositaryAddress(address newDepositaryAddress) public onlyOwner {
        require(newDepositaryAddress!=address(0), "Depositary address can not be empty");
        DepositaryAddress=newDepositaryAddress;
    }
    function CheckForDepositarySigned(address contractAddress) public returns(bool)
    {
        if (!Contracts[contractAddress].DepositarySigned)
            Contracts[contractAddress].DepositarySigned=Depositary(DepositaryAddress).SignedContracts(contractAddress);
        return Contracts[contractAddress].DepositarySigned;        
    }
    
    
     address UnderwriterAddress;
     function   SetUnderwriterAddress(address newUnderwriterAddress) public onlyOwner {
        require(newUnderwriterAddress!=address(0), "UnderwriterAddress address can not be empty");
        UnderwriterAddress=newUnderwriterAddress;
    }
    
    function CheckForUnderwriterSigned(address contractAddress) public returns(bool)
    {
        if (!Contracts[contractAddress].UnderwriterSigned)
            Contracts[contractAddress].UnderwriterSigned=Underwriter(UnderwriterAddress).SignedContracts(contractAddress);
        return Contracts[contractAddress].UnderwriterSigned;        
    }


 
    address public  QuubeVerifiedListAddress;
    function   SetVerifiedListAddress(address newVerifiedListAddress) public onlyOwner
    {
        require(newVerifiedListAddress!=address(0), "VerifiedList address can not be empty");
        QuubeVerifiedListAddress=newVerifiedListAddress;
    }
    
    
    
    address QuubeSignerAddress;
     function   SetQuubeSignerAddress(address newQuubeSignerAddress) public onlyOwner {
        require(newQuubeSignerAddress!=address(0), "Depositary address can not be empty");
        QuubeSignerAddress=newQuubeSignerAddress;
    }

    function CheckForQuubeSigned(address contractAddress) public returns(bool)
    {
        //require(QuubeVerifiedList(msg.sender).CheckAddress(msg.sender), "QuubeSignerAddress admin only address can add contract");
        if (!Contracts[contractAddress].QuubeSigned)
            Contracts[contractAddress].QuubeSigned=QuubeSigner(QuubeSignerAddress).SignedContracts(contractAddress);
        return Contracts[contractAddress].QuubeSigned;        
    }
 
    
     
}
