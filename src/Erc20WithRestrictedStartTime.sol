pragma solidity ^0.5.11;

import "./ERC20Template.sol";


contract QuubeErc20WithRestrictedStartTime is QuubeErc20Template {
    
    uint256 public TradingStartTime=1573862400;

    constructor(address contractOwner, string memory contractName,string memory contractSymbol, uint256 totalSupply ,  uint256 tradingStartTime) QuubeErc20Template(contractOwner,contractName,contractSymbol,totalSupply) public payable
    {
        TradingStartTime=tradingStartTime;
    }
    

    function transfer(address to, uint256 value)  public  returns (bool) {
        require(block.timestamp<TradingStartTime,"Can not sell before TradingStartTime");
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(block.timestamp<TradingStartTime,"Can not sell before TradingStartTime");
        return super.transferFrom(from,to,value);
    }

}