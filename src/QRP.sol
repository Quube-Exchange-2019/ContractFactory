pragma solidity ^0.5.11;
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


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

contract QuubeContract is Ownable, ERC20 {
string public name = "QuuBe";
string public symbol = "QRP";

uint256 private _totalSupply=250000000;
uint256 private _tokesforSale=175000000;


address _salesManager ;
function TransferFromContractAddress(address to, uint256 value) public returns(bool)
{
    require(msg.sender==_salesManager,"Send tokens from contract address can only SalesManager");
    _transfer(address(this), to, value);
    return true;
}

function SetManager(address newManager) public onlyOwner returns(bool)
{
    _salesManager=newManager;
}

constructor(address contractOwner) Ownable(contractOwner) public{
    super._mint(address(this),_tokesforSale);
    super._mint(contractOwner,_totalSupply - _tokesforSale);
}

function burn(uint256 value) public onlyOwner {
        _burn(msg.sender, value);
    }


}
