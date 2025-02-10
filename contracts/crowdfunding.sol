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

    function getContractBalance() public view returns (uint){
        return address(this).balance;
    }

    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target, "You are not elgible for refund");
        require(contributers[msg.sender]>0, "You are not contributor");
        payable(msg.sender).transfer(contributers[msg.sender]);
        contributers[msg.sender]=0;
    }

    function voteRequest(uint _requestNo) public{
        require(contributers[msg.sender]>0,"You are not a contributer");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo) public onlyManager{
        require(raisedAmount >= target, "target is not reached");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed == false, "the request has been completed");
        require(thisRequest.noOfVoters>noOfContributers/2, "majority does not support the request");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;
    }
}