
pragma solidity ^0.4.16;

contract CreateInsurance{
    
    address public client;
    address public insurer;
    uint256 public insuranceValue;
    uint256 public insuranceCost;
    
    function CreateInsurance(address _client, address _insurer, uint _insuranceValue, uint _insuranceCost) payable{
        client = _client;
        insurer = _insurer;
        insuranceCost = _insuranceCost;
        insuranceValue = _insuranceValue;
    }
    
    function payClient() {
        client.transfer(insuranceValue);
         selfdestruct(insurer);
    }
    
    function getGas() public returns(uint){
        return this.balance ;
    }
    function payInsurer() {
        insurer.transfer(insuranceCost);
         selfdestruct(insurer);
    }
 
      function getInsuranceValue() constant public returns(uint){
        return insuranceValue;
      }
}

contract Insurance{
    
    mapping(address => address) public clients;
    address public owner;
    
    function  Insurance() payable{
        owner = msg.sender;
    }
    
    function clientSignUp() payable{
        uint cost = msg.value;
        clients[msg.sender] = (new CreateInsurance).value(100*msg.value+10000)(msg.sender , owner ,  10*msg.value,msg.value);
    }
    
    function getInsuranceValue() public constant returns(uint){
        return (CreateInsurance(clients[msg.sender]).getInsuranceValue());
    }
    
    function determineResult(bool settle) public payable{
        if(settle){
            CreateInsurance(clients[msg.sender]).payClient();
        } else {
            CreateInsurance(clients[msg.sender]).payInsurer();
        }
    }
        
    function getClientEther() public constant returns(uint){
            return msg.sender.balance;
        }
        
    function getInsurerEther() public constant returns(uint){
            return owner.balance;
        }
        
        function test() returns (address, uint) {
            return (CreateInsurance(clients[msg.sender]) , CreateInsurance(clients[msg.sender]).getGas());
        }
}