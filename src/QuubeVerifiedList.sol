pragma solidity ^0.5.11;
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/access/roles/WhitelistedRole.sol";

contract QuubeVerifiedList is WhitelistedRole
{
    function CheckAddress(address Address) public view returns(bool)
    {
        return super.isWhitelisted(Address);
    }
}