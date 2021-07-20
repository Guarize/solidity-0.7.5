pragma solidity 0.7.5;

import "./Ownable.sol";
import "./Destroyable.sol";

contract Bank is Destroyable {
   
   mapping(address => uint) balance;
   
   event depositDone(uint amountAdded, address indexed depositedTo);
   
   event transferEvent(address indexed FromAddress, uint amountTransfered, address indexed ToAddress);
   
   function deposit() public payable returns(uint){
       balance[msg.sender] += msg.value;
       emit depositDone(msg.value, msg.sender);
       return balance[msg.sender];
   }
   
   function getBalance() public view returns(uint){
       return balance[msg.sender];
   }
   
   function withdraw(uint amount) public onlyOwner returns(uint) {
       //msg.sender is an address
       require(balance[msg.sender] >= amount);
       msg.sender.transfer(amount);
       return balance[msg.sender];
   }
   
   function transfer(address recipient, uint amount) public {
       require(balance[msg.sender] >= amount, "Balance not Sufficient.");
       require(msg.sender != recipient, "Don't transfer money to yourself.");
       
       uint previousSenderBalance = balance[msg.sender];
       
       _transfer(msg.sender, recipient, amount);
       emit transferEvent(msg.sender, amount, recipient);
       
       assert(balance[msg.sender] == previousSenderBalance - amount);
   }
   
   function _transfer(address from, address to, uint amount) private {
       balance[from] -= amount;
       balance[to] += amount;
   }
   
}
