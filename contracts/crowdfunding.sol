// SPDX-License-Tdentifier: GPL-3.0

// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding{

    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=> bool) voters;
    }

    mapping(address=>uint) public contributers;
    mapping (uint=> Request) public requests;
    uint public numRequests;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributers;

    constructor(uint _target, uint _deadline ){
        target = _target;
        deadline = block.timestamp+_deadline;
        minimumContribution=10 wei;
        manager = msg.sender;

    }

    modifier onlyManager(){
        require(msg.sender==manager, "you are not manager");
        _;
    }
    function createRequests(string calldata _description, address payable _recipient, uint _value ) public onlyManager{ 
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;  
    }

    function contribution() public payable{
        require(block.timestamp<deadline, "Deadline has passed");
        require(msg.value>=minimumContribution,"payment should be more than minimum contribution");

        if(contributers[msg.sender]==0){
            noOfContributers++;
        }
        contributers[msg.sender]+=msg.value;
        raisedAmount+=msg.value;

    }
}