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
}