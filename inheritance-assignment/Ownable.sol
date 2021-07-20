pragma solidity 0.7.5;

contract Ownable {
    
    address payable owner;
   
   constructor(){
       owner = msg.sender;
   }
   
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // run the function
   }
   
}