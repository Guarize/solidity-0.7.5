pragma solidity 0.7.5;
import "./Ownable.sol";

contract Destroyable is Ownable {
    
    function close() public onlyOwner{
        address payable receiver = msg.sender;
        selfdestruct(receiver);
    }
    
}