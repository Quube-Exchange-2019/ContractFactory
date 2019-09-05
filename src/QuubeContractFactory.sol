pragma solidity ^0.5.11;

import "./Ownable.sol";
import "./ERC20Template.sol";
import "./QuubeVerifiedList.sol";
import "./QuubeContractList.sol";

contract QuubeContractFactory is Ownable
{
    event NewContractCreated(
        address indexed contractAddress,
        string name, 
        string symbol, 
        uint totalSupply 
    );

     function createErc20Contract (address ownerAddress, string memory name,string memory contractSymbol, uint256 totalSupply) public returns (address) {
        require(QuubeVerifiedList( QuubeVerifiedListAddress).CheckAddress(msg.sender), "Whitelisted  only address can create contract");
        address newContract = address(new QuubeErc20Template(ownerAddress,name,contractSymbol,totalSupply));
        PushToList(newContract,ownerAddress,name,contractSymbol,totalSupply);
        emit NewContractCreated(newContract,name,contractSymbol,totalSupply);
        return newContract;
    } 
    
    constructor (address ContractsList) Ownable(msg.sender) public 
    {
        require(ContractsList!=address(0), "ContractList address can not be empty");
        contractListAddress=ContractsList;
    }
    
    address public  contractListAddress;
    function   SetContractsListAddress(address newContractListAddress) public onlyOwner
    {
        require(newContractListAddress!=address(0), "ContractList address can not be empty");
        contractListAddress=newContractListAddress;
    }

    address public  QuubeVerifiedListAddress;
    function   SetVerifiedListAddress(address newVerifiedListAddress) public onlyOwner
    {
        require(newVerifiedListAddress!=address(0), "VerifiedList address can not be empty");
        QuubeVerifiedListAddress=newVerifiedListAddress;
    }
    
    function PushToList(address contractAddress, address ownerAddress, string memory name,string memory contractSymbol, uint256 totalSupply) internal returns(bool)
    {
        require(contractListAddress!=address(0), "ContractList not available");
        return QuubeContractList(contractListAddress).AddContract(contractAddress,ownerAddress,name,contractSymbol,totalSupply);
    }
    
    
}