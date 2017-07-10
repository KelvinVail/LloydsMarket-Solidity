pragma solidity ^0.4.4;

contract MarketEntityRegister {
  mapping (bytes32=> address) public entity;

  function register(bytes32 name) {
    if(entity[name] == 0 && name != ""){
      entity[name] = msg.sender;
    }
  }

  function unregister(bytes32 name) {
    if(entity[name] != 0 && name != ""){
      entity[name] = 0x0;
    }
  }
}
