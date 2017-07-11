pragma solidity ^0.4.4;

contract Bank {
  
  address owner;

  mapping (address => uint) balances;

  function Bank(){
  }

  function setOwner(address newOwner) returns (bool res) {
    if (owner != 0x0 && msg.sender != owner){
      return false;
    }
    owner = newOwner;
    return true;
  }

  function deposit(address customer) returns (bool res) {
    if (msg.value == 0){
      return false;
    }
    balances[customer] += msg.value;
    return true;
  }

  function withdraw(address customer, uint amount) returns (bool res) {
    if(balances[customer] < amount || amount == 0)
      return false;
    balances[msg.sender] -= amount;
    msg.sender.send(amount);
    return true;
  }

  function remove() {
    if(msg.sender == owner){
      selfdestruct(owner);
    }
  }

}

contract FundManager {

  address owner;

  address bank;

  mapping (address => uint) perms;

  function FundManager(){
    owner = msg.sender;
    bank = new Bank();
    Bank(bank).setOwner(address(this));
  }

  function setBank(address newBank) constant returns (bool res) {
    if (msg.sender != owner){
      return false;
    }

    bool result = Bank(newBank).setOwner(address(this));

    if(!result){
      return false;
    }
    bank = newBank;
    return true;
  }

  function selfdestructBank(address addr) {
    if (msg.sender != owner){
      return;
    }
    Bank(addr).remove();
  }

  function setPermission(address user, uint perm) constant returns (bool res) {
    if (msg.sender != owner){
      return false;
    }
    perms[user] = perm;
    return true;
  }

  function deposit() returns (bool res) {
    if (msg.value == 0){
      return false;
    }
    if (bank == 0x0) {
      msg.sender.send(msg.value);
      return false;
    }

    if(perms[msg.sender] != 1){
      return false;
    }

    bool success = Bank(bank).deposit.value(msg.value)(msg.sender);

    if (!success) {
      msg.sender.send(msg.value);
    }
    return success;
  }

  function withdraw(uint amount) returns (bool res) {
    if (bank == 0x0) {
      return false;
    }

    if(perms[msg.sender] != 1){
      return false;
    }
    
    bool success = Bank(bank).withdraw(msg.sender, amount);

    if (success) {
      msg.sender.send(amount);
    }
    return success;
  }

}
