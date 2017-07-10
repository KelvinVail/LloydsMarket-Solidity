var MarketEntityRegister = artifacts.require("./MarketEntityRegister.sol");

contract('MarketEntityRegister', function(accounts) {
  it("should register a name for account one", function() {
    var mer;
    var account_addr = accounts[0];
    var name = "Account One";
    var return_addr;

    return MarketEntityRegister.deployed().then(function(instance) {
      mer = instance;
      return mer.register(name, {from: account_addr});
    }).then(function() {
      return mer.entity(name);
    }).then(function(addr) {
     return_addr = addr;

      assert.equal(account_addr, return_addr, "the wrong entity address was returned for account one");
    });
  });
  it("should register a name for account two", function() {
    var mer;
    var account_addr = accounts[1];
    var name = "Account Two";
    var return_addr;

    return MarketEntityRegister.deployed().then(function(instance) {
      mer = instance;
      return mer.register(name, {from: account_addr});
    }).then(function() {
      return mer.entity(name);
    }).then(function(addr) {
     return_addr = addr;

      assert.equal(account_addr, return_addr, "the wrong entity address was returned for account two");
    });
  });
});
