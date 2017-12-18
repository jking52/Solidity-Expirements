contract Agreement {
 
    bool registrationOpen = true;
    address public owner;
    address[] public clients;
    mapping(address => bool) public clientsConfirmed;
     
    modifier onlyOwner {
         require (msg.sender == owner);
         _;
     }
     
     modifier onlyClient {
         require (isAClient(msg.sender));
         _;
     }
     
     modifier clientsRegistered {
         require (clients.length > 0);
         _;
     }
    
     modifier registerOpen{
         require(registrationOpen);
         _;
     }
     
      modifier registerClosed{
         require(!registrationOpen);
         _;
     }
    
     function Agreement() public {
          owner = msg.sender;
     } 
    
    function isAClient(address client) internal constant returns(bool){
        for(uint i=0; i<clients.length; i++){
            if (clients[i] == client) {
                return true;
            }
            return false;
        }
    }
     
    function registerClient(address client) public onlyOwner registerOpen {
         /* Not previously registered*/
         require(!isAClient(client));
         /*add to list and increment client count*/
         clients.push(client);
         clientsConfirmed[client] = false;
     }
     
    function confirm() public onlyClient {
        clientsConfirmed[msg.sender] = true;
    }
    
    function closeRegistration() public onlyOwner registerOpen {
        registrationOpen =false;
    }
    
    function agreementReached() public constant clientsRegistered registerClosed returns (bool) {
        for(uint i=0; i<clients.length; i++){
            if (!clientsConfirmed[clients[i]]) {
                return false;
            }
            return true;
        }
    }
    
}    