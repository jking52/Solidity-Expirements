contract Agreement {
    
    address client1;
    address client2;
    bool client1Confirmed = false;
    bool client2Confirmed = false;
    
    modifier onlyClient1 {
        require(msg.sender == client1);
        _;
    }
    
    modifier client1Assigned {
         require(client1 != 0);
         _;
    }
    
    modifier client2Assigned {
         require(client2 != 0);
         _;
    }
    
    modifier client1Unassigned {
         require(client1 == 0);
         _;
    }
    
    modifier client2Unassigned {
         require(client2 == 0);
         _;
    }
    
     modifier onlyClient2 {
        require(msg.sender == client2);
        _;
    }
    
    function registerClient1() public client1Unassigned {
        client1 = msg.sender;
    }
    
    function registerClient2() public client2Unassigned {
        client2 = msg.sender;
    }
    
    function confrimClient1() public client1Assigned onlyClient1 {
        client1Confirmed = true;
    }
    
    function confrimClient2() public client2Assigned onlyClient2 {
        client2Confirmed = true;
    }
    
    function agreementReached() public constant returns(bool) {
        return (client1Confirmed == true && client2Confirmed == true);
    }
}