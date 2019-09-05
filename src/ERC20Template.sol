pragma solidity ^0.5.11;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./Ownable.sol";
import "./QuubeVerifiedList.sol";


contract QuubeErc20Template is Ownable, ERC20 {
    
    string public name = "Quube ERC20 template";
    string public symbol = "ERC20_";

    constructor(address contractOwner, string memory contractName,string memory contractSymbol, uint256 totalSupply) Ownable(contractOwner) public payable
    {
        name=contractName;
        symbol=contractSymbol;
        super._mint(contractOwner,totalSupply);
    }
    
    
       event NotAClient(address adressTo);

    function detectTransferRestriction ( address to) public view returns (uint8) {
        
        return CheckVerified(to)?0:1;
    }

    function transfer(address to, uint256 value)  public  returns (bool) {

        require(CheckVerified(to),"'to' Adress is not verifieded");
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(CheckVerified(from),"'from' Adress is not verifieded");
        require(CheckVerified(to),"'to' Adress is not verifieded");
        return super.transferFrom(from,to,value);
    }
    address verifiedListAddress;
    function   SetVerifiedList(address newVerifiedListAddress) public onlyOwner
    {
        verifiedListAddress=newVerifiedListAddress;
    }
    
    function CheckVerified(address traderAdress) private view returns (bool)
    {
        require(verifiedListAddress!=address(0), "VerifiedList not assigned");
        return QuubeVerifiedList(verifiedListAddress).CheckAddress(traderAdress);
    }
}